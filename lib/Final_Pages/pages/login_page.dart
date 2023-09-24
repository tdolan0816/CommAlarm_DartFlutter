

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:commalarm_app/Final_Pages/database/commalarmDB2.dart';
import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';
import 'package:commalarm_app/Final_Pages/pages/newAcctPage.dart';
import 'package:commalarm_app/Final_Pages/pages/AddEditAcctPage.dart';
import 'package:commalarm_app/Final_Pages/pages/homePageTest.dart';


void main() => runApp(
  ChangeNotifierProvider(
    
      create: (_) => EmailProvider(),
  child: const MyApp())
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body:  LoginPage(),
      ),
    );
  }
}


class LoginPage extends StatefulWidget {

  const LoginPage({

    Key? key, 
    }) : super(key: key);

  
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
    Future _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final database = await openDatabase(path, version: 2);

    return database;
  }



  late List<NewAccount> newAccounts;

  bool isLoading = false;

  final _formLoginKey = GlobalKey<FormState>();


  late NewAccount newAccount;
  static Database? _database;

    @override
  void initState() {
    super.initState();
    // refreshAccounts();
    _initDB('commalarm2.db');
    

  }



    Future refreshAccounts() async {
    setState(() => isLoading = true);
    newAccounts = await CommAlarmDatabase.instance.readAllNewAccounts();
    setState(() => isLoading = false);
  }
  

  Future<String> getLogin() async {
    var dbClient = await _initDB('commalarmDB.db');
    var result = await dbClient.rawQuery('SELECT * FROM newAccounts WHERE email = ? AND reEnterPassword = ?', [emailController.text, passwordController.text]);
    if (result.length == 0) {
      return 'fail';
    } else {
      return 'success';
    }
  }






  @override
  Widget build(BuildContext context) {
    
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: 
                 Image.asset('assets/images/comm_alarm_logo.jpg'),
                ),


            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                style: const TextStyle(
                  fontFamily: 'Nunito Sans Light 300',
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Email is required'),
                  EmailValidator(errorText: 'Enter a valid email address'),

                  
                ]),
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
                onChanged: (value) {
                  Provider.of<EmailProvider>(context, listen: false).email = value;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                style: const TextStyle(
                  fontFamily: 'Nunito Sans Light 300',
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Password is required'),
                  MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
                  MaxLengthValidator(15, errorText: 'Password must not be longer than 15 digits')
                ]),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed:() {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  fontFamily: 'Nunito Sans Light 300',
                ),
          
                ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Nunito Sans Light 300',
                    ),
                    ),
          
                  onPressed: () {
                    
                    _initDB('commalarmDB.db');

                    // refreshAccounts();
                    if (emailController.text == 'admin' &&
                        passwordController.text == 'admin') {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DatabaseView()),
                    );
                        } else {
                    if (emailController.text == 'user' &&
                        passwordController.text == 'user') {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const MainHomePageTest()),
                    );
                    } else {
                      getLogin().then((value) {
                        if (value == 'success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const MainHomePageTest()),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Failed'),
                                content: const Text('Incorrect email or password'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      // getFirstName() async {
                      //   var dbClient = await _initDB('commalarmDB.db');
                      //   var results = await dbClient.rawQuery('SELECT firstName FROM newAccounts WHERE email = ? ', [emailController.text]);
                        
                      //   return results;
                      // }
                      // getFirstName().then((value) {
                      //   Provider.of<EmailProvider>(context, listen: false).firstName = value[0]['firstName'];
                      //   String firstNameResults = Provider.of<EmailProvider>(context, listen: false).firstName;
                      //   print(firstNameResults);
                      // });
                      });
            
                    }  
                  }
                  },

                )),

     
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Don\'t Have an Account?',
                  style: TextStyle(
                      fontFamily: 'Nunito Sans Light 300',
                    ),),
                TextButton(
                  child: const Text(
                    'Click Here',
                    style: TextStyle(fontSize: 20,
                    fontFamily: 'Nunito Sans Light 300',
                    ),
                  ),
                  onPressed: () {

                    _initDB('commalarmDB.db');
                    // refreshAccounts();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddEditAcctPage()),
                    );
                  },
                )
              ],
            )
    ],
        ));
  }
}


class EmailProvider with ChangeNotifier{
  String _email = '';
  String _firstName = '';

  String get email => _email;
  String get firstName => _firstName;

  set email(String email){
    _email = email;

    notifyListeners();
  }

  set firstName(String firstName){
    _firstName = firstName;
    notifyListeners();
  }
}
