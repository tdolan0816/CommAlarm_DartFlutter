// ignore_for_file: library_private_types_in_public_api, prefer_final_fields
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/directions.dart' as dir;
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:http/http.dart' as http;

import 'package:commalarm_app/Final_Pages/database/commalarmDB2.dart';
import 'package:commalarm_app/Final_Pages/pages/gridview_buttonTest.dart';
import 'package:commalarm_app/Final_Pages/pages/login_page.dart';
import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';
import 'package:commalarm_app/Final_Pages/pages/homePageTest.dart';

import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';





void main() {
  runApp(const MaterialApp(
    home: GMapsTrafficBuildTest(),
  ));
}

class GMapsTrafficBuildTest extends StatefulWidget {
  const GMapsTrafficBuildTest({Key? key}) : super(key: key);

  @override
  _GMapsTrafficBuildTestState createState() => _GMapsTrafficBuildTestState();
}

class _GMapsTrafficBuildTestState extends State<GMapsTrafficBuildTest> {
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> completer = Completer();
  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  final PolylinePoints _polylinePoints = PolylinePoints();
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> controller = Completer();
  var durationInTraffic = '';

  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController durationInTrafficController = TextEditingController();
  String _email = '';
  final String apiKey = "AIzaSyAmZLhTQHom2dJRlRoM3uqVe4zEi47b9AY";

  Future _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final database = await openDatabase(path, version: 2);

    return database;
  }

      @override
  void initState() {
    super.initState();
    _initDB('commalarmDB.db');
    
   
  }

   _getEmailFromProvider(BuildContext context) {
    final emailProvider = Provider.of<EmailProvider>(context, listen: false);
    _email = emailProvider.email;
  }

  

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (!completer.isCompleted) {
      completer.complete(controller);
    }
  }


  void _getRouteCoordinates(String origin, String destination) async {
    List locations = await locationFromAddress(origin);
    LatLng originLatLng = LatLng(locations[0].latitude, locations[0].longitude);

    locations = await locationFromAddress(destination);
        LatLng destinationLatLng =
        LatLng(locations[0].latitude, locations[0].longitude);

    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAmZLhTQHom2dJRlRoM3uqVe4zEi47b9AY',
      PointLatLng(originLatLng.latitude, originLatLng.longitude),
      PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylines.clear();
        _polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        Polyline polyline = Polyline(
          polylineId: const PolylineId('route'),
          color: const Color.fromARGB(255, 255, 4, 4),
          points: _polylineCoordinates,
          width: 4,
        );

        _polylines.add(polyline);
      });

      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('Origin'),
            position: originLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('Destination'),
            position: destinationLatLng,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });

      if (_polylineCoordinates.isNotEmpty) {
        LatLngBounds bounds = LatLngBounds(
          southwest: LatLng(
            _polylineCoordinates.first.latitude,
            _polylineCoordinates.first.longitude,
          ),
          northeast: LatLng(
            _polylineCoordinates.last.latitude,
            _polylineCoordinates.last.longitude,
          ),
        );

        _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      }
    }
  }

//   buildDurationInTraffic(context) async {
//     final departureTime = DateTime.now().add(const Duration(minutes: 2));
//     try {
//     final directions = dir.GoogleMapsDirections(
//         apiKey: 'AIzaSyAmZLhTQHom2dJRlRoM3uqVe4zEi47b9AY');
//     final response = await directions.directionsWithAddress(
//       originController.text,
//       destinationController.text,
//       region: const Locale('en', 'US').countryCode,
//       departureTime: departureTime,
//       trafficModel: dir.TrafficModel.bestGuess,
//       travelMode: dir.TravelMode.driving,

//     );


//     if (response.isOkay) {
//       final route = response.routes[0];
//       final leg = route.legs[0];
//       var durationInTraffic = leg.durationInTraffic?.text;
//       print('Duration In Traffic: $durationInTraffic');
//       return durationInTraffic;
  
//     } else {
//       print('Error: ${response.errorMessage}');
//       return 'Error';
//     }
//   } catch (e) {
//     print('Error: $e');
//     return 'Error';
//   }
// }

  




  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    super.dispose();
  }



submitBuildCondensed() async {
  final origin = originController.value.text;
  final destination = destinationController.value.text;
// Remove the 'final' keyword
  setState(() {
    durationInTrafficController.text = durationInTraffic;
  });

  _getRouteCoordinates(origin, destination);
  setState(() {
    durationInTrafficController.text = durationInTraffic;
    print('Duration In Traffic: $durationInTraffic');
    if (origin == '' || destination == '') {
      return;
    }
  });
}

    void submitData() {
      
    String durationInTraffic = durationInTrafficController.text;
    String origin = originController.text;
    String destination = destinationController.text;
    _getRouteCoordinates(origin, destination);
    setState(() {
      durationInTrafficController.text = durationInTraffic;
      print ('Duration In Traffic: $durationInTraffic');
    if (origin == '' || destination == '' ) {
    
      return; 
    }

    });
  }

  //   // final DBDataModel dbDataModel = DBDataModel(
  //   //   id: 0, 
  //   //   origin: origin,
  //   //   destination: destination,
  //   //   durationInTraffic: durationInTraffic,
  //   // );

  //   // if (dbDataModel.id == null) {
  //   //   await DataBaseHelper.insertData(dbDataModel);
  //   // } else {
  //   //   await DataBaseHelper.updateData(dbDataModel);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
      final email = Provider.of<EmailProvider>(context, listen: false).email; 

  _getEmailFromProvider(context);

    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.all(30),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 2,
          left: 15,
          right: 15,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(190, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Stack(
            children: [
              GoogleMap(
                onMapCreated: onMapCreated,
                polylines: _polylines,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749,
                      -122.4194), // Default map position (San Francisco)
                  zoom: 12,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: _markers,
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoTextField(
                      controller: originController,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(190, 255, 255, 255),
                            Color.fromARGB(190, 255, 255, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CupertinoTextField(
                      controller: destinationController,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(190, 255, 255, 255),
                            Color.fromARGB(190, 255, 255, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),

                    const SizedBox(height: 5),

                    ElevatedButton(
                      onPressed: () async {
                          var dbClient = await _initDB('commalarmDB.db');
                          
                          var result = await dbClient.rawUpdate(
                            'UPDATE newAccounts SET orgAddress = ?, destAddress = ? WHERE email = ?',
                            [originController.text, destinationController.text, email],
                          );
                          // Handle the result as needed
                          print('Update result: $result');
                          submitBuildCondensed();
                        },
                      
                      // ignore: sort_child_properties_last
                      child: const Text('Submit Locations Selection'),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size.fromHeight(40.0)),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePageTest(),
                        ),
                      ),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size.fromHeight(40.0)),
                      ),
                      child: const Text('Go to Main Screen'),
                    ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        
      );
    }
  }
