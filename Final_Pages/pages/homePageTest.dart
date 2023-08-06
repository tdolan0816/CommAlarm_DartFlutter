
// ignore_for_file: file_names

import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:commalarm_app/Final_Pages/database/commalarmDB2.dart';
import 'package:commalarm_app/Final_Pages/pages/gridview_buttonTest.dart';
import 'package:commalarm_app/Final_Pages/pages/login_page.dart';


void main() {
  runApp(
    const HomePageTest(),
  );
}



class HomePageTest extends StatelessWidget {
  const HomePageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CommAlarm Mobile Application',
      home: MainHomePageTest(

      ),
    );
  }
}

class MainHomePageTest extends StatefulWidget {
  
   const MainHomePageTest({


    Key? key, 
  }) : super(key: key);
  

  @override
  State<MainHomePageTest> createState() => _MainHomePageTestState();
}

class _MainHomePageTestState extends State<MainHomePageTest> {
  String alarmTime = '0:00';
  String estTime = '0:00';
  String freqDate = 'Everyday';
  String readyTimeFinal = '0:00'; 
  String startDate = '';
  String endDate = '';
  DateTime dateAlarmPicker = DateTime.now();
  TimeOfDay timeAlarmPicker = TimeOfDay.now();
  String _email = '';
  String firstNameResults = '';
  String alarmTimeResults = '';
  String readyTimeResults = '';
  String readyTimeFinalFormat1 = '';
  String readyTimeFinalFormat2 = '';
  String estTimeResults = '';
  String startDateResults = '';
  String endDateResults = '';
  String freqDateResults = '';

  // final _formHomePageKey = GlobalKey<FormState>();
  

  // static final CommAlarmDatabase instance = CommAlarmDatabase.instance;
  // static Database? _database;

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
    getFirstName();
   
  }

   _getEmailFromProvider(BuildContext context) {
    final emailProvider = Provider.of<EmailProvider>(context, listen: false);
    _email = emailProvider.email;
  }

  Future getFirstName() async {
    var dbClient = await _initDB('commalarmDB.db');
    var firstNameResults = await dbClient.rawQuery('SELECT firstName FROM newAccounts WHERE email = ? ', [_email]);
    
    return firstNameResults = firstNameResults[0]['firstName'];

          }
          
  Future<String?> getAlarmTime() async {


  if (alarmTimeResults.isEmpty || alarmTime.isEmpty) {
    var dbClient = await _initDB('commalarmDB.db');
    var alarmTimeResults = await dbClient.rawQuery(
      'SELECT alarmTime FROM newAccounts WHERE email = ?', [_email]);
      // Data exists in the database, return the value from the database.
    return alarmTimeResults[0]['alarmTime'].toString();
  } else {
    // Data does not exist in the database, return the default value from the TimePicker.
    return alarmTime;
  }
}

  // Future getAlarmTime() async {
  //   var dbClient = await _initDB('commalarmDB.db');
  //   var alarmTimeResults = await dbClient.rawQuery('SELECT alarmTime FROM newAccounts WHERE email = ? ', [_email]);
    
  //   return alarmTimeResults = alarmTimeResults[0]['alarmTime'];

  //         }

  Future<String?> getReadyTime() async {
  if (readyTimeResults.isEmpty || readyTimeFinal.isEmpty) {
    var dbClient = await _initDB('commalarmDB.db');
    var readyTimeResults = await dbClient.rawQuery(
      'SELECT readyTimeFinal FROM newAccounts WHERE email = ?', [_email]);
      // Data exists in the database, return the value from the database.
    return readyTimeResults[0]['readyTimeFinal'].toString();
  } else {
    // Data does not exist in the database, return the default value from the TimePicker.
    return readyTimeFinal;
  }
}

  Future<String?> getEstArrvlTime() async {
  if (estTimeResults.isEmpty || estTime.isEmpty) {
    var dbClient = await _initDB('commalarmDB.db');
    var estTimeResults = await dbClient.rawQuery(
      'SELECT estTime FROM newAccounts WHERE email = ?', [_email]);
      // Data exists in the database, return the value from the database.
    return estTimeResults[0]['estTime'].toString();
  } else {
    // Data does not exist in the database, return the default value from the TimePicker.
    return estTime;
  }
}


  Future<String?> getStartDateRange() async {
  if (startDateResults.isEmpty || startDate.isEmpty) {
    var dbClient = await _initDB('commalarmDB.db');
    var startDateResults = await dbClient.rawQuery(
      'SELECT startDate FROM newAccounts WHERE email = ?', [_email]);
      // Data exists in the database, return the value from the database.
    return startDateResults[0]['startDate'].toString();
  } else {
    // Data does not exist in the database, return the default value from the TimePicker.
    return startDate;
  }
}

  Future<String?> getEndDateRange() async {
  if (endDateResults.isEmpty || endDate.isEmpty) {
    var dbClient = await _initDB('commalarmDB.db');
    var endDateResults = await dbClient.rawQuery(
      'SELECT endDate FROM newAccounts WHERE email = ?', [_email]);
      // Data exists in the database, return the value from the database.
    return endDateResults[0]['endDate'].toString();
  } else {
    // Data does not exist in the database, return the default value from the TimePicker.
    return endDate;
  }
}

  Future<String?> getFreqDate() async {
  if (freqDateResults.isEmpty || freqDate.isEmpty) {
    var dbClient = await _initDB('commalarmDB.db');
    var freqDateResults = await dbClient.rawQuery(
      'SELECT freqDate FROM newAccounts WHERE email = ?', [_email]);
      // Data exists in the database, return the value from the database.
    return freqDateResults[0]['freqDate'].toString();
  } else {
    // Data does not exist in the database, return the default value from the TimePicker.
    return freqDate;
  }
}

  


    
  startDateRange() {
    if(startDate == endDate) {
      return startDate;
    } else {
      return '$startDate - $endDate';
    }
  }

  callbackT(changeTime) {
    setState(() {
      alarmTime = changeTime;
    });
  }

  callbackESTTime(changeTime) {
    setState(() {
      estTime = changeTime;
    });
  }

  callback(changedate) {
    setState(() {
      readyTimeFinal = changedate;
    });
  }

  callbackstartDate(changeDate) {
    setState(() {
      startDate = changeDate;
    });
  }

  callbackendDate(changeDate) {
    setState(() {
      endDate = changeDate;
    });
  }

  callback2(changedate) {
    setState(() {
      dateAlarmPicker = changedate;
    });
  }

    callbackfreqTime(changeFreqTime) {
    setState(() {
        freqDate = changeFreqTime;
      });
    }

  


  var alarmIcon = Icons.alarm_sharp;
  var settingsIcon = Icons.settings_sharp;
  var helpIcon = Icons.help_sharp;
  var infoIcon = Icons.info_sharp;

  @override
  Widget build(BuildContext context) {

  final email = Provider.of<EmailProvider>(context, listen: false).email; 
  String firstNameResults = Provider.of<EmailProvider>(context, listen: false).firstName;
  _getEmailFromProvider(context);




    return
    Card(
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

                  FutureBuilder(future: getFirstName(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      firstNameResults = snapshot.data.toString();
                      return Text(
                        firstNameResults,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          // fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Text('Loading...');
                    }
                  }),

                  //  Text(
                  //   firstNameResults,
                  //   style: const TextStyle(
                  //     fontFamily: 'Nunito Sans Light 300' ,
                  //     // fontWeight: FontWeight.bold,
                  //     fontSize: 26,
                  //     color: Colors.white,
                  //   ),
                  // ),

                  const SizedBox(height: 55),

                  const Text('Current Alarm Settings',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Nunito Sans Light 300' ,
                        fontSize: 22,   
                        color: Colors.white,
                        )),

                  const SizedBox(height: 10),
                  
                  Row(
                    
                    children: [
                      const Icon(Icons.alarm_sharp, color: Colors.white),

                      const SizedBox(width: 10),

                FutureBuilder(future: getAlarmTime(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      alarmTimeResults = snapshot.data.toString();
                      return Text(
                        alarmTimeResults,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          // fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Text(alarmTime);
                    }
                  }),
                

                const SizedBox(width: 10),

                FutureBuilder(future: getEstArrvlTime(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      estTimeResults = snapshot.data.toString();
                      return Text(
                        'ETA: $estTimeResults',
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 16, 67, 129),
                        ),
                      );
                    } else {
                      return Text(estTime);
                    }
                  }),
                ], 
              ),

                const SizedBox(height: 10),

                Row(
                  children: [
                  const Icon(Icons.run_circle_outlined, color: Colors.white),

                  const SizedBox(width: 10),

                FutureBuilder(future: getReadyTime(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      readyTimeResults = snapshot.data.toString();
                      return Text(
                       readyTimeResults,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          // fontWeight: FontWeight.bold,
                          fontSize: 20,

                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Text(
                        readyTimeFinal,

                        );
                    }
                  }),
                  ], 
                ),
                  
                  const SizedBox(height: 10),
                
                Row(
                  children: [
                  const Icon(
                    Icons.calendar_today, 
                    color: Colors.white54,
                    size: 18,
                    ),

                  const SizedBox(width: 10),

                  FutureBuilder(future: getStartDateRange(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      startDateResults = snapshot.data.toString();
                      return Text(
                        startDateResults,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white54,
                        ),
                      );
                    } else {
                      return Text(startDate);
                    }
                  }),

                  const Text(' - ',
                    style: TextStyle(
                      fontFamily: 'Nunito Sans Light 300' ,
                      fontSize: 22,
                      color: Colors.white54,
                    ),
                  ),

                  FutureBuilder(future: getEndDateRange(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      endDateResults = snapshot.data.toString();
                      return Text(
                        endDateResults,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white54,
                        ),
                      );
                    } else {
                      return Text(endDate);
                    }
                  }),
                  ],
                ),

                  const SizedBox(height: 5),

                FutureBuilder(future: getFreqDate(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      freqDateResults = snapshot.data.toString();
                      return Text(
                        freqDateResults,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans Light 300' ,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(202, 16, 180, 240),
                        ),
                      );
                    } else {
                      return Text(endDate);
                    }
                  }),
                  

                ],
          ),
        ),
            
             Positioned(
              top: 35,
              left: 300,
              child: 
              Card(
                  color: const Color.fromARGB(255, 126, 189, 245),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: 275,
                    width: 65,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                  
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      IconButton(
                        iconSize: 35,
                        icon: Icon(alarmIcon),
                        color: const Color.fromARGB(255, 92, 145, 189),
                        onPressed: () async {
                          var dbClient = await _initDB('commalarmDB.db');
                          
                          var result = await dbClient.rawUpdate(
                            'UPDATE newAccounts SET alarmTime = ?, estTime = ?, readyTimeFinal = ?, freqDate = ?, startDate = ?, endDate = ? WHERE email = ?',
                            [alarmTime, estTime, readyTimeFinal, freqDate, startDate, endDate, email],
                          );
                          // Handle the result as needed
                          print('Update result: $result');
                        },
                      ),  

                    

                      IconButton(
                        iconSize: 35,
                        icon: Icon(settingsIcon),
                        color: const Color.fromARGB(255, 92, 145, 189),
                        onPressed: () async {
                          var dbClient = await _initDB('commalarmDB.db');
                          
                          var result = await dbClient.rawQuery(
                            'SELECT firstName FROM newAccounts WHERE email = ?',
                            [email],
                          );
                          // Handle the result as needed
                          print('Update result: $result');
                        }
                      ), 

                      IconButton(
                        iconSize: 35,
                        icon: Icon(helpIcon),
                        color: const Color.fromARGB(255, 92, 145, 189),
                        onPressed: () {},
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: Icon(infoIcon),
                        color: const Color.fromARGB(255, 92, 145, 189),
                        onPressed: () {},
                      ),],
                    ),
                  )
              ),
            
            ),
            Positioned(
                top: 350,
                left: 0,
                child:
                GridViewButtonsBuildTest(    
                  callbackfreqTime: callbackfreqTime,
                  alarmInputTime: alarmTime,
                  callback: callback,
                  callback2: callback2,
                  callbackstartDate: callbackstartDate,
                  callbackendDate: callbackendDate,
                  callbackT: callbackT,
                  callbackESTTime: callbackESTTime,
                  freqDate: freqDate,
                  readyTimeFinal: readyTimeFinal,
                  startDate: startDate,
                  endDate: endDate, 
              ),
            ),
            ],),
      ), 


    );
  }
}
