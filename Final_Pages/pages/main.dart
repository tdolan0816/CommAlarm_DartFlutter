import 'package:commalarm_app/Final_Pages/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:commalarm_app/Final_Pages/pages/newAcctPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,

        themeMode: ThemeMode.light,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 255, 255, 255),
          scaffoldBackgroundColor: const Color.fromARGB(255, 14, 150, 217),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: LoginPage(),
      );
}