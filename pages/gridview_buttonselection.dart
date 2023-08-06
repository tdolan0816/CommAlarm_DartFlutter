import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:commalarm_app/Final_Pages/pages/gmaps_traffic_build_test.dart';
import 'package:commalarm_app/pages/review_card.dart';
import 'package:intl/intl.dart';

// void main() => runApp(const GridViewButtonsBuild());
 

class GridViewButtonsBuild extends StatefulWidget {


   GridViewButtonsBuild({
    Key? key,  
    required this.date2,
    required this.time2,
    required this.callback,  
    required this.callback2,
    required this.callbackT,
    required this.callbackT2,  
    }) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _GridViewButtonsBuildState createState() => _GridViewButtonsBuildState();
  String date2;
  String time2;
  Function(dynamic changedate) callback;
  Function(dynamic changedate) callback2;
  Function(dynamic changeTime) callbackT;
  Function(dynamic changeTime) callbackT2;




}

class _GridViewButtonsBuildState extends State<GridViewButtonsBuild> {

int _radioValue1 = -1;
  
 radioValueChange(int value) {

    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          "Weekdays Only";
          break;
        case 1:
          "Weekends Only";
          break;
        case 2:
          "Everyday";
          break;
      }
    });
  }


  Future<void> _showAdditionalDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 25, 15),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          backgroundColor: const Color.fromARGB(255, 67, 69, 71),
          titleTextStyle: const 
            TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              color: Color.fromARGB(233, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              ),

          title: const Text(
            'Frequency of Alarm',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              color: Color.fromARGB(233, 255, 255, 255),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              ),
            ),

          content:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30, width: 100), 
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
            Text('Weekdays\n Only', 
              textAlign: TextAlign.center,
              style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                color: Color.fromARGB(233, 255, 255, 255),
                fontSize: 14,
                  )
                ),
               SizedBox(width: 25),
               Text('Weekends\n Only',
                textAlign: TextAlign.center,
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  color: Color.fromARGB(233, 255, 255, 255),
                  fontSize: 14,
                  )
                ),
               SizedBox(width: 35),
               Text('All\n Week',
                textAlign: TextAlign.center,
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  color: Color.fromARGB(233, 255, 255, 255),
                  fontSize: 14,
                  )
                ),
                ],
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              const SizedBox(width: 15),
                Radio(
                  value: 0, 
                  groupValue: _radioValue1, 
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value as int;
                    });
                  },),
                const SizedBox(width: 40),
                
                Radio(
                  value: 1, 
                  groupValue: _radioValue1, 
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value as int;
                    });
                  },),
                const SizedBox(width: 42.5),
  
                Radio(
                  value: 2, 
                  groupValue: _radioValue1, 
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value as int;
                    });
                  },),
              ],
             ),

              ],
            ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the additional dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

         Future<void>  _selectTime(BuildContext context) async {
          final TimeOfDay? pickedDate = await showDatePicker(context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2021),
          lastDate: DateTime(2024),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.dark(),
              child: child!,
            );
          },
          
          ).then((dateAlarmPicker) {
            setState(() {
               _showAdditionalDialog(context);
              widget.date2 = DateFormat('MM/dd/yyyy').format(dateAlarmPicker!);
              widget.callback(widget.date2);
          

            
            });
             
          });
        }


  @override
  // Widget build(BuildContext context) {
  //   return 
Widget build(BuildContext context) {
return 
    SizedBox(
      height: 400,
      width: 400,
      child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: <Widget>[
          TextButton(
            onPressed: () =>
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GMapsTrafficBuildTest()),
              ),
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              fontSize: 20, fontWeight: 
              FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Locations\n',
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Origin, Destination and Mode of Transport',
                    style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
           
          ),
          TextButton(
            onPressed: () {
               showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.dark(),
              child: child!,
            );
          },
              ).then((timeAlarmPicker) {
                setState(() {
                widget.time2 = timeAlarmPicker!.format(context);
                widget.callbackT(widget.time2);
              

                });
              });
            },
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(
                  fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Alarm Times\n',
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Desired Alarm, Arrival, Ready Times',
                    style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),



      TextButton(
        onPressed:() {
          _selectTime(context);
        },
        //   showDatePicker(context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(2021),
        //   lastDate: DateTime(2024),
        //   builder: (BuildContext context, Widget? child) {
        //     return Theme(
        //       data: ThemeData.dark(),
        //       child: child!,
        //     );
        //   },
        //   ).then((dateAlarmPicker) {
        //     setState(() {
        //       widget.date2 = DateFormat('MM/dd/yyyy').format(dateAlarmPicker!);
        //       widget.callback(widget.date2);
          

            
        //     });
        //                 _showAdditionalDialog(context);
        //   });
        // },

        
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(
                  fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Dates\n',
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Start Date, End Date, and Frequency of Alarm\n',
                    style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          
          TextButton(
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(
                  fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Date Range\n',
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set a Date Range for the Alarm to be Active',
                    style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////          
          const SizedBox(
            height: 75,
          )

        ],
      ),
    );
  }
}