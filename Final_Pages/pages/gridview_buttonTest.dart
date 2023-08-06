
import 'package:commalarm_app/Final_Pages/pages/gmaps_traffic_build_test.dart';
import 'package:flutter/material.dart';

import 'package:commalarm_app/pages/gmaps_traffic_build.dart';
import 'package:commalarm_app/pages/review_card.dart';
import 'package:intl/intl.dart';


// void main() => runApp(const GridViewButtonsBuild());
 

class GridViewButtonsBuildTest extends StatefulWidget {
  String alarmInputTime;
  



   GridViewButtonsBuildTest({
    Key? key,  
    this.freqDate,
    this.alarmTime,
    this.estTime,
    this.readyTimeFinal,
    this.startDate,
    this.endDate,
    required this.callback,  
    required this.callback2,
    required this.callbackstartDate,
    required this.callbackendDate,
    required this.callbackT,
    required this.callbackESTTime,
    required this.callbackfreqTime,

    required this.alarmInputTime, 

    }) : super(key: key);
  

  
  @override
  // ignore: library_private_types_in_public_api
  _GridViewButtonsBuildTestState createState() => _GridViewButtonsBuildTestState();
  String? freqDate;
  String? alarmTime;
  String? estTime;
  String? readyTimeFinal;
  String? startDate;
  String? endDate;
  Function(dynamic changedate) callback;
  Function(dynamic changedate) callback2;
  Function(dynamic changedate) callbackstartDate;
  Function(dynamic changedate) callbackendDate;
  Function(dynamic changeTime) callbackT;
  Function(dynamic changeESTTime) callbackESTTime;
  Function(dynamic changeFreqTime) callbackfreqTime;





}

class _GridViewButtonsBuildTestState extends State<GridViewButtonsBuildTest> {
  String freqValue = '';
  String readyTimeString = '';
  String readyTimeFinal = '';
  String readyTimeForCalc = '';
  String readyTimeForCalc2 = '';
  String readyTime2 = '';
  String readyTime3 = '';
  String readyTimeFormatted = '';
  String readyTimeFormatted2 = '';
  String readyTimeFormatFinal = '';




  
  // void _outputFreqValues (int? value) {
  //   setState(() {
  //     widget.freqDate = value.toString();
  //     widget.callbackfreqTime(widget.freqDate);
  //     if (value == 1) {
  //       widget.freqDate = 'Weekdays Only';
  //       widget.callbackfreqTime(widget.freqDate);
  //     }
  //     if (value == 2) {
  //       widget.freqDate = 'Weekends Only';
  //       widget.callbackfreqTime(widget.freqDate);
  //     }
  //     if (value == 3) {
  //       widget.freqDate = 'Everyday';
  //       widget.callbackfreqTime(widget.freqDate);
  //     }
  //   });
  // }

  Future<void> _selectTime(BuildContext context) async {
    showTimePicker(
      helpText: 'SET ALARM TIME',
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
      return  Theme(
          data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.highContrastDark(
          primary: Color.fromARGB(255, 255, 255, 255),
          surface: Color.fromARGB(255, 50, 50, 50),
          onSurface: Color.fromARGB(255, 119, 159, 223),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          labelSmall:  TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              color: Color.fromARGB(233, 255, 255, 255),
              fontSize: 16,
              ),
        ),
      ),
        child: child!,
      );
    },
      ).then((timeAlarmPicker) {
          setState(() {
          widget.alarmTime = timeAlarmPicker!.format(context);
          widget.callbackT(widget.alarmTime);
        showTimePicker(
      helpText: 'SET EST. TIME OF ARRIVAL',
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
      return  Theme(
          data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.highContrastDark(
          primary: Color.fromARGB(255, 255, 255, 255),
          surface: Color.fromARGB(255, 50, 50, 50),
          onSurface: Color.fromARGB(255, 119, 159, 223),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          labelSmall:  TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              color: Color.fromARGB(233, 255, 255, 255),
              fontSize: 16,
              ),
        ),
      ),
        child: child!,
      );
    },
      ).then((timeEstPicker) {
          setState(() {
          widget.estTime = timeEstPicker!.format(context);
          widget.callbackESTTime(widget.estTime);
          });
        });
          });
        });
      }
  



    
  Future<void> _selectReadyTime(BuildContext context) async {
    showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
      return Theme(
          data: Theme.of(context).copyWith(
              
        colorScheme: const ColorScheme.highContrastDark(
          primary: Color.fromARGB(255, 255, 255, 255),
          surface: Color.fromARGB(255, 50, 50, 50),
          onSurface: Color.fromARGB(255, 119, 159, 223),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          labelSmall:  TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              color: Color.fromARGB(233, 255, 255, 255),
              fontSize: 16,
              ),
        ),
      ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      );
    },
        ).then((readyTimePicker) {
              readyTimeString = readyTimePicker.toString();
              // readyTimeForCalc = readyTimeString.replaceAll('AM', '');
              // readyTimeFormatted = readyTimeForCalc.replaceAll('PM', '');
              // readyTimeFormatted2 = readyTimeFormatted.padRight(10,''); 
              // readyTimeFormatFinal = readyTimeFormatted2.padLeft(1,'');
              // readyTime2 = readyTimeForCalc2.replaceAll(':', ' hrs.  ');
              // readyTime3 = readyTime2.replaceAll('AM', ' mins.  ');
              // readyTimeFormatted = readyTime3.replaceAll('PM', ' mins.  ');
          setState(() {
          readyTime2 = readyTimeString.replaceAll('TimeOfDay(', '');
          readyTime3 = readyTime2.replaceAll(')', '');
          widget.readyTimeFinal = readyTime3;
          widget.callback(widget.readyTimeFinal);

  showDialog(
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
               Text('Everyday',
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
                  value: 'WEEKDAYS ONLY', 
                  activeColor: Colors.blue,
                  fillColor: MaterialStateProperty.all(Colors.blue),
                  toggleable: true,
                  groupValue: freqValue, 
                  onChanged: 
                    (value) =>
                      setState(() {
                    widget.freqDate = value.toString();
                    widget.callbackfreqTime(widget.freqDate); 
                    freqValue = value.toString();
                    }),
                  ),


                const SizedBox(width: 40),
                
                Radio<String>(
                  value: 'WEEKENDS ONLY', 
                  activeColor: Colors.blue,
                  fillColor: MaterialStateProperty.all(Colors.blue),
                  toggleable: true,
                  groupValue: freqValue, 
                  onChanged:  
                    (value) =>
                      setState(() {
                    widget.freqDate = value.toString();
                    widget.callbackfreqTime(widget.freqDate); 
                    freqValue = value.toString();

                    }),
                  ),

                const SizedBox(width: 42.5),
  
                Radio<String>(
                  value: 'EVERYDAY', 
                  activeColor: Colors.blue,
                  fillColor: MaterialStateProperty.all(Colors.blue),
                  toggleable: true,
                  groupValue: freqValue, 
                  onChanged: 
                    (value) =>
                      setState(() {
                    widget.freqDate = value.toString();
                    widget.callbackfreqTime(widget.freqDate); 
                    freqValue = value.toString();

                    }),
                   
                  ),
              ],
             ),

              ],
            ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the additional dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  );
  }
  );
  }




      _selectDateRange() async {
      DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          initialDateRange: DateTimeRange(
            end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
            start: DateTime.now(),
          ),
      builder: (BuildContext context, Widget? child) {
      return  Theme(
          data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 44, 44, 44),
          surface: Color.fromARGB(255, 50, 50, 50),
          onSurface: Color.fromARGB(255, 119, 159, 223),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          labelSmall:  TextStyle(
              fontFamily: 'Nunito Sans Light 300',
              color: Color.fromARGB(233, 255, 255, 255),
              fontSize: 16,
              ),
        ),
      ),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 375.0,
                    maxHeight: 600.0,
                  ),
                  child: child!,
                ),
              ],
            ),
      );
      },

      ).then((dateRangeAlarmPicker) {
        setState(() {
          widget.startDate = DateFormat('MM/dd/yyyy').format(dateRangeAlarmPicker!.start);
          widget.endDate = DateFormat('MM/dd/yyyy').format(dateRangeAlarmPicker.end);
          widget.callbackstartDate(widget.startDate);
          widget.callbackendDate(widget.endDate);
    
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
              _selectTime(context);
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
                    text: 'Set Desired Alarm and Estimated Time of Arrival',
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
          _selectReadyTime(context);
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
                text: 'Ready Time\n',
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Amount of Time to Get Ready and Freq of Alarm\n',
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
            onPressed: 
            () {
              _selectDateRange();
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
                text: 'Date Range\n',
                style: TextStyle(
              fontFamily: 'Nunito Sans Light 300',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set a Date Range for the Alarm to be Active\n',
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