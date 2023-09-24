// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';


import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';
import 'package:commalarm_app/Final_Pages/database/commalarmDB2.dart';
import 'package:commalarm_app/Final_Pages/widgets/acctFormWidget.dart';

class AddEditAcctPage extends StatefulWidget {
  final NewAccount? newAccount;

  const AddEditAcctPage({
    Key? key,
    this.newAccount,
  }) : super(key: key);
  @override
  _AddEditAcctPageState createState() => _AddEditAcctPageState();
}

class _AddEditAcctPageState extends State<AddEditAcctPage> {
  final _formKey = GlobalKey<FormState>();
  late String firstName; 
  late String lastName;
  late String email;

  late String reEnterPassword;
  late String mobileNo;
  late String address;
  late String? alarmTime;
  late String? estTime;
  late String? readyTimeFinal; 
  late String? freqDate; 
  late String? startDate; 
  late String? endDate; 
  late String? orgAddress; 
  late String? destAddress; 
  late String? commTime; 
  late String? calcAlarmTime; 
  late String? field1;
  late String? field2;





  @override
  void initState() {
    super.initState();

    firstName = widget.newAccount?.firstName ?? '';
    lastName = widget.newAccount?.lastName ?? '';
    email = widget.newAccount?.email ?? '';

    reEnterPassword = widget.newAccount?.reEnterPassword ?? '';
    mobileNo = widget.newAccount?.mobileNo ?? '';
    address = widget.newAccount?.address ?? '';
    alarmTime = widget.newAccount?.alarmTime ?? '';
    estTime = widget.newAccount?.estTime ?? '';
    readyTimeFinal = widget.newAccount?.readyTimeFinal ?? '';
    freqDate = widget.newAccount?.freqDate ?? '';
    startDate = widget.newAccount?.startDate ?? '';
    endDate = widget.newAccount?.endDate ?? '';
    orgAddress = widget.newAccount?.orgAddress ?? '';
    destAddress = widget.newAccount?.destAddress ?? '';
    commTime = widget.newAccount?.commTime ?? '';
    calcAlarmTime = widget.newAccount?.calcAlarmTime ?? '';
    field1 = widget.newAccount?.field1 ?? '';
    field2 = widget.newAccount?.field2 ?? '';




  }

  @override
  Widget build(BuildContext context) => Scaffold(

        body: Form(
          key: _formKey,
          child: AcctFormWidget(
            firstName: firstName,
            lastName: lastName,
            email: email,
            reEnterPassword: reEnterPassword,
            mobileNo: mobileNo,
            address: address,

            firstNameChanged: (firstName) =>
                setState(() => this.firstName = firstName),
            lastNameChanged: (lastName) => setState(() => this.lastName = lastName),
            emailChanged: (email) => setState(() => this.email = email),
           
            reEnterPasswordChanged: (reEnterPassword) =>
                setState(() => this.reEnterPassword = reEnterPassword),
            mobileNoChanged: (mobileNo) => setState(() => this.mobileNo = mobileNo),
            onSavedNewAccount: () => addorUpateAcct(),

            addressChanged: (address) => setState(() => this.address = address),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = email.isNotEmpty && mobileNo.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addorUpateAcct,
        child: Text('test'),
      ),
    );
  }

  void addorUpateAcct() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.newAccount != null;

      if (isUpdating) {
        await updateAcct();
      } else {
        await addAcct();
      }

      Navigator.of(this.context).pop();
    }
  }

  Future updateAcct() async {
    final newAccount = widget.newAccount!.copy(
      firstName: firstName,
      lastName: lastName,
      email: email,

      reEnterPassword: reEnterPassword,
      mobileNo: mobileNo,
      address: address,
      alarmTime: alarmTime,
      estTime: estTime,
      readyTimeFinal: readyTimeFinal,
      freqDate: freqDate,
      startDate: startDate,
      endDate: endDate,
      orgAddress: orgAddress,
      destAddress: destAddress,
      commTime: commTime,
      calcAlarmTime: calcAlarmTime,
      field1: field1,
      field2: field2,


    );

    await CommAlarmDatabase.instance.update(newAccount);
  }

  Future addAcct() async {
    final newAccount = NewAccount(
      firstName: firstName,
      lastName: lastName,
      email: email,

      reEnterPassword: reEnterPassword,
      mobileNo: mobileNo,
      address: address,
      alarmTime: alarmTime??'',
      estTime: estTime??'',
      readyTimeFinal: readyTimeFinal??'',
      freqDate: freqDate??'',
      startDate: startDate??'',
      endDate: endDate??'',
      orgAddress: orgAddress??'',
      destAddress: destAddress??'',
      commTime: commTime??'',
      calcAlarmTime: calcAlarmTime??'',
      field1: field1??'',
      field2: field2??'',
      

      
    );

    await CommAlarmDatabase.instance.create(newAccount);
  }
}