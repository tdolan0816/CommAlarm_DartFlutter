// import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:path/path.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   static const String _title = 'Sample App';

//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.blue),
//       title: _title,
//       home: const Scaffold(
//         body:  LoginPage(),
//       ),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: <Widget>[
//             const SizedBox(height: 20),
//             Container(
//               color: const Color.fromRGBO(253, 253, 253, 1),
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//                 child: 
//                  Image.asset('assets/images/comm_alarm_logo.jpg'),
//                 ),


//             Container(
//               padding: const EdgeInsets.all(10),
//               child: TextFormField(
//                 style: const TextStyle(
//                   fontFamily: 'Nunito Sans Light 300',
//                 ),
//                 validator: MultiValidator([
//                   RequiredValidator(errorText: 'Email is required'),
//                   EmailValidator(errorText: 'Enter a valid email address'),
                  
//                 ]),
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Email Address',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               child: TextFormField(
//                 style: const TextStyle(
//                   fontFamily: 'Nunito Sans Light 300',
//                 ),
//                 validator: MultiValidator([
//                   RequiredValidator(errorText: 'Password is required'),
//                   MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
//                   MaxLengthValidator(15, errorText: 'Password must not be longer than 15 digits')
//                 ]),
//                 obscureText: true,
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 //forgot password screen
//               },
//               child: const Text(
//                 'Forgot Password',
//                 style: TextStyle(
//                   fontFamily: 'Nunito Sans Light 300',
//                 ),
//                 ),
//             ),
//             // Container(
//             //     height: 50,
//             //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//             //     child: ElevatedButton(
//             //       child: const Text(
//             //         'Login',
//             //         style: TextStyle(
//             //           fontFamily: 'Nunito Sans Light 300',
//             //         ),
//             //         ),
//             //       onPressed: () {
//             //         if (emailController.text == 'admin' &&
//             //             passwordController.text == 'admin') {
//             //           Navigator.pushNamed(context, ');
//             //         } else {
//             //           ScaffoldMessenger.of(context).showSnackBar(
//             //               const SnackBar(content: Text('Invalid Login')));
//             //         }
                    
//             //       },
//             //     )
//             // ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const Text(
//                   'Don\'t Have an Account?',
//                   style: TextStyle(
//                       fontFamily: 'Nunito Sans Light 300',
//                     ),),
//                 TextButton(
//                   child: const Text(
//                     'Click Here',
//                     style: TextStyle(fontSize: 20,
//                     fontFamily: 'Nunito Sans Light 300',
//                     ),
//                   ),
//                   onPressed: () {
//                     //signup screen
//                   },
//                 )
//               ],
//             ),
//           ],
//         ));
//   }
// }