import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dartpy/dartpy.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';


import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';
import 'package:commalarm_app/Final_Pages/database/commalarmDB2.dart';
import 'package:commalarm_app/Final_Pages/pages/AddEditAcctPage.dart';

class AcctDetailPage extends StatefulWidget {
  final int newAcctId;

  const AcctDetailPage({
    Key? key,
    required this.newAcctId,
  }) : super(key: key);

  @override
  _AcctDetailPageState createState() => _AcctDetailPageState();
}

class _AcctDetailPageState extends State<AcctDetailPage> {
  NewAccount? newAccount;
  String durationInTrafficFinal = "";
  String durationInTraffic = "";
  String durTraffCalcFormat = "";
  String formattedHours = "";
  String formattedMinutes = "";
  String formattedTime = "";
  late Duration fullCommuteTime;
  late DateTime newAlarmTime;
  late DateTime oldCommuteTime;
  late DateTime newCommuteTime;
  late String finalAlarmTime; 
  int hoursInt = 0;
  int minutesInt = 0;
  bool isLoading = false;

  Future refreshNote() async {
    setState(() => isLoading = true);

    newAccount =
        await CommAlarmDatabase.instance.readNewAccount(widget.newAcctId);

    setState(() => isLoading = false);
  }

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
    refreshNote();
    getDurationInTraffic();

  }

  //Function to get Traffic Data, parse it, and return it as a String
  Future<String?> getDurationInTraffic() async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=${newAccount?.orgAddress}&destinations=${newAccount?.destAddress}&departure_time=now&key=AIzaSyAmZLhTQHom2dJRlRoM3uqVe4zEi47b9AY");

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      if (values["rows"] != null &&
          values["rows"].length > 0 &&
          values["rows"][0]["elements"] != null &&
          values["rows"][0]["elements"].length > 0 &&
          values["rows"][0]["elements"][0]["duration_in_traffic"] != null &&
          values["rows"][0]["elements"][0]["duration_in_traffic"]["text"] !=
              null) {
        var durationInTraffic =
            values["rows"][0]["elements"][0]["duration_in_traffic"]["text"];

        print(durationInTraffic);

        if(durationInTraffic.toString().contains('mins')) {
          durTraffCalcFormat = durationInTraffic.toString()
          .replaceAll(RegExp(' hour'), ':')
          .replaceAll(RegExp('mins'), '')
          .replaceAll(RegExp(' '), '');
          print('formatted time1: $durTraffCalcFormat');
          return durTraffCalcFormat;
        }

        if(durationInTraffic.toString().contains('min')) {
          durTraffCalcFormat = durationInTraffic.toString()

          .replaceAll(RegExp(' min'), '')
          .replaceAll(RegExp(' hour'), ':0');
          print('formatted time2: $durTraffCalcFormat');
          return durTraffCalcFormat;
        }

        if(durationInTraffic.toString().contains('hour')) {
          durTraffCalcFormat = durationInTraffic.toString()
          .replaceAll(RegExp(' hour'), ':')
          .replaceAll(RegExp(' mins'), '')
          .replaceAll(RegExp(' minutes'), '')
          .replaceAll(RegExp(' min'), '');
          print('formatted time3: $durTraffCalcFormat');
          return durTraffCalcFormat;
        } 


      }
    }
  }


  //Function to format the Ready Time to a usable format
  Duration parseTimeToDuration(String timeString) {
    List<String> parts = timeString.split(':');

    if (parts.length != 2) {
      // Handle invalid time format here (e.g., throw an exception or return a default value).
      throw FormatException("Invalid time format: $timeString");
    }

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    return Duration(hours: hours, minutes: minutes);
  }

  //Function to calculate the new alarm time
  Future<String> calcNewAlarmTime() async {
    DateFormat format = DateFormat("HH:mm");
    DateTime alarmTimeCalc = format.parse(newAccount!.alarmTime);
    DateTime estTime = format.parse(newAccount!.estTime);
    String readyTimeString = newAccount!.readyTimeFinal; // Replace this with the actual value from your code.
    Duration readyTimeDuration = parseTimeToDuration(readyTimeString);
    // Duration trafficDuration = parseTimeToDuration(durTraffCalcFormat);


    // fullCommuteTime = readyTimeDuration + trafficDuration;
    // oldCommuteTime = alarmTimeCalc.add(fullCommuteTime);
    // newCommuteTime = estTime.subtract(fullCommuteTime);
    // newAlarmTime = estTime.subtract(fullCommuteTime);

    // if(oldCommuteTime.isAfter(estTime)){
    //   newAlarmTime;
    // } else {
    //   newAlarmTime = alarmTimeCalc; 
    // }

    // Format the new alarm time.
    // finalAlarmTime = DateFormat('h:mm a').format(newAlarmTime);

    // print('Commute Time: $fullCommuteTime');
    // print('New Alarm: $finalAlarmTime');
    // print('Ready Time Duration: $readyTimeDuration');

    return readyTimeString;
  }

  
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton(), trafficButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      "${newAccount?.firstName} ${newAccount?.lastName}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 88, 178, 252), // [900
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Email: ${newAccount?.email}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Phone: ${newAccount?.mobileNo}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Password ${newAccount?.reEnterPassword}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'User Address: ${newAccount?.address}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Alarm Time: ${newAccount?.alarmTime}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Est. Arrvl Time: ${newAccount?.estTime}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Amt. Time to Get Ready: ${newAccount?.readyTimeFinal}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Freq of Alarm: ${newAccount?.freqDate}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Alarm Start Date: ${newAccount?.startDate}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Alarm End Date: ${newAccount?.endDate}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Org. Address: ${newAccount?.orgAddress}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Dest. Address: ${newAccount?.destAddress}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),

                    // const SizedBox(height: 8),

                    // Text(
                    //   'Commute Time: ${newAccount?.commTime}',
                    //   style: const TextStyle(
                    //     color: Color.fromARGB(255, 0, 0, 0),
                    //     fontSize: 18),
                    // ),

                    // const SizedBox(height: 8),

                    // Text(
                    //   'New Calc. Alarm Time: ${newAccount?.calcAlarmTime}',
                    //   style: const TextStyle(
                    //     color: Color.fromARGB(255, 0, 0, 0),
                    //     fontSize: 18),
                    // ),

                    const SizedBox(height: 8),

                    FutureBuilder<String?>(
                      future:
                          getDurationInTraffic(), // Call your asynchronous function here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                        } else if (snapshot.hasData) {
                          return Text(
                            'Duration in Traffic: ${snapshot.data!}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Display an error message if something went wrong
                        } else {
                          return const Text(
                              'Press the button to fetch data'); // Display a message before pressing the button
                        }
                      },
                    ),

                    const SizedBox(height: 8),

                    FutureBuilder(
                      future:
                          calcNewAlarmTime(), // Call your asynchronous function here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                        } else if (snapshot.hasData) {
                          return Text(
                            'New Calc. Alarm Time: ${snapshot.data!}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Display an error message if something went wrong
                        } else {
                          return const Text(
                              'Press the button to fetch data'); // Display a message before pressing the button
                        }
                      },
                    ),
                  ],
                ),
              ),
      );

  Widget trafficButton() => IconButton(
      icon: const Icon(Icons.traffic),
      onPressed: () async {
        getDurationInTraffic();
        // calcNewAlarmTime();
      });

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(this.context).push(MaterialPageRoute(
          builder: (context) => AddEditAcctPage(newAccount: newAccount),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await CommAlarmDatabase.instance.delete(widget.newAcctId);

          Navigator.of(this.context).pop();
        },
      );
}
