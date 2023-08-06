import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:intl/intl.dart';

import 'package:commalarm_app/pages/review_sidebutton_card.dart';
import 'package:commalarm_app/pages/gridview_buttonselection.dart';
import 'package:commalarm_app/pages/review_card.dart';

void main() {
  runApp(
    const CommAlarmMainHomePage(),
  );
}

class CommAlarmMainHomePage extends StatelessWidget {
  const CommAlarmMainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CommAlarm Mobile Application',
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({

    Key? key,
  }) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  String time2 = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String date2 = DateFormat('MM/dd/yyyy').format(DateTime.now()).toString();

  DateTime dateAlarmPicker = DateTime.now();
  TimeOfDay timeAlarmPicker = TimeOfDay.now();

  callbackT(changeTime) {
    setState(() {
      time2 = changeTime;
    });
  }

  callbackT2(changeTime) {
    setState(() {
      timeAlarmPicker = changeTime;
    });
  }

  callback(changedate) {
    setState(() {
      date2 = changedate;
    });
  }

  callback2(changedate) {
    setState(() {
      dateAlarmPicker = changedate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(
        5, 35, 5, 5),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: SizedBox(
        width: 400,
        height: 1200,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              height: 350,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade300,
                    Colors.blue.shade400,
                    Colors.blue.shade600,
                    Colors.blue.shade800,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text('Welcome to CommAlarm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      fontFamily: 'Nunito Sans Light 300' ,
                        fontSize: 18, 
                        color: Colors.white)),
                  const SizedBox(height: 10),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontFamily: 'Nunito Sans Light 300' ,
                      // fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Text('Current Alarm Settings',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Nunito Sans Light 300' ,
                        fontSize: 20,   
                        color: Colors.white,
                        )),
                  const SizedBox(height: 10),

                  Text(time2,
                    style: const TextStyle(
                      fontFamily: 'Nunito Sans Light 300' ,
                      fontSize: 28,
                      color: Color.fromARGB(255, 148, 220, 250),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text('Alarm Dates:   $date2', 
                    style: const TextStyle(
                      fontFamily: 'Nunito Sans Light 300' ,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            ),
            const Positioned(
              top: 35,
              left: 300,
              child: SideButtonsCardBuild(),
            ),
            Positioned(
                top: 350,
                left: 0,
                child:
                GridViewButtonsBuild(    
                  callback: callback,
                  callback2: callback2,
                  time2: time2,
                  callbackT: callbackT,
                  callbackT2: callbackT2,
                  date2: date2,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
