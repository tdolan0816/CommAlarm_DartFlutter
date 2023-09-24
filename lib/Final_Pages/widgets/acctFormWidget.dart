import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_maps_webservice/directions.dart';

class AcctFormWidget extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? email;

  final String? reEnterPassword;
  final String? mobileNo;
  final String? address;


  final ValueChanged firstNameChanged;
  final ValueChanged lastNameChanged;
  final ValueChanged emailChanged;

  final ValueChanged reEnterPasswordChanged;
  final ValueChanged mobileNoChanged;
  final ValueChanged addressChanged;


  final VoidCallback onSavedNewAccount;

  




  const AcctFormWidget( {
    Key? key,
    this.firstName = '',
    this.lastName = '',
    this.email = '',

    this.reEnterPassword = '',
    this.mobileNo = '',
    this.address = '',

    required this.firstNameChanged,
    required this.lastNameChanged,
    required this.emailChanged,

    required this.reEnterPasswordChanged,
    required this.mobileNoChanged,
    required this.addressChanged,

    required this.onSavedNewAccount,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              
              color: Color.fromARGB(255, 255, 255, 255),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: 
                 Image.asset('assets/images/comm_alarm_logo.jpg'),
                ),
            Container(
              padding: const EdgeInsets.all(10),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                buildFirstName(),
                const SizedBox(height: 15),
                buildLastName(),
                const SizedBox(height: 15),
                buildEmail(),
                const SizedBox(height: 15),
                buildPassword(),
                const SizedBox(height: 15),
                buildReEnterPassword(),
                const SizedBox(height: 15),
                buildMobileNo(),
                const SizedBox(height: 15),
                buildAddress(),
                const SizedBox(height: 15),


                buildButton1(),
              ],
            ),
            ),
          ],
        ),
      );
  }

    Widget buildFirstName() => 
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
        validator: (firstName) =>
            firstName != null && firstName.isEmpty ? 'This Field cannot be empty' : null,
   
        onChanged: firstNameChanged,
      );

    Widget buildLastName() =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
        validator: (lastName) =>
            lastName != null && lastName.isEmpty ? 'This Field cannot be empty' : null,
        onChanged: lastNameChanged,
      );

    Widget buildEmail() =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),

        validator: (email) =>
            email != null && email.isEmpty ? 'This Field cannot be empty' : null,
        onChanged: emailChanged,
      );

      Widget buildPassword() =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
        validator:  (password) {
                  if (password!.isEmpty) return 'Empty';
                  if (password.length < 6) return 'Too short';
                  if (password.length > 15) return 'Too long';
                  if (!password.contains(RegExp(r'[0-9]'))) return 'Missing number';
                  if (!password.contains(RegExp(r'[A-Z]'))) return 'Missing uppercase letter';
                  return null;
                },


      );

    Widget buildReEnterPassword() =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: 
                (reEnterPassword) {
                  if (reEnterPassword!.isEmpty) return 'Empty';
                  if (reEnterPassword.length < 6) return 'Too short';
                  if (reEnterPassword.length > 15) return 'Too long';
                  if (!reEnterPassword.contains(RegExp(r'[0-9]'))) return 'Missing number';
                  if (!reEnterPassword.contains(RegExp(r'[A-Z]'))) return 'Missing uppercase letter';
                  return null;
                },

        onChanged: reEnterPasswordChanged,
      );



    Widget buildMobileNo() =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile Number',
                ),
        validator: (mobileNo) =>
            mobileNo != null && mobileNo.isEmpty ? 'This Field cannot be empty' : null,
        onChanged: mobileNoChanged,
      );

    Widget buildAddress() =>
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: Color.fromARGB(255, 14, 13, 13),
          fontFamily: 'Nunito Sans Light 300',
        ),
        decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
        validator: (address) =>
            address != null && address.isEmpty ? 'This Field cannot be empty' : null,

        onChanged: addressChanged,
      );


    Widget buildButton1() =>
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all( Colors.blue),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2), 
              ),
            ),
          ),
          onPressed: onSavedNewAccount,
          child: const Text(
            'Submit',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), 
              fontSize: 20,
            ),
          ),
        ),
      );
      
  }

