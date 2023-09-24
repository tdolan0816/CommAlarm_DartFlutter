// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:commalarm_app/Final_Pages/pages/homePageTest.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';
import 'package:commalarm_app/Final_Pages/database/commalarmDB2.dart';
import 'package:commalarm_app/Final_Pages/pages/AcctDetailPage.dart';





class DatabaseView extends StatefulWidget {
  const DatabaseView({super.key});

  @override
  _DatabaseViewState createState() => _DatabaseViewState();
}

class _DatabaseViewState extends State<DatabaseView> {

  late Future<Database> database;

  late List<NewAccount> newAccounts;
  late NewAccount newAccount;


  bool isLoading = false;
  
  int newAlarmId = 0;
  
  

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  // @override
  // void dispose() {
  //   CommAlarmDatabase.instance.close();

  //   super.dispose();
  // }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    newAccounts = await CommAlarmDatabase.instance.readAllNewAccounts();

    setState(() => isLoading = false);
  }

  Future refreshAlarm() async {
    setState(() => isLoading = true);
    newAccounts = await CommAlarmDatabase.instance.readAllNewAccounts();

    setState(() => isLoading = false);
  }



  Future _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final database = await openDatabase(path, version: 2);

    return database;
  }

  Future _initAlarmDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final database = await openDatabase(path, version: 2);

    return database;
  }




  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Database View',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          
          child: isLoading
              ? const CircularProgressIndicator()
              : newAccounts.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(), 
                  
        
        ), 
        );


        Widget buildNotes() => ListView.builder(
        itemCount: newAccounts.length,
        itemBuilder: (context, index) {
          final newAccount = newAccounts[index];

          return Dismissible(
            key: Key(newAccount.id.toString()),
            onDismissed: (direction) {
              setState(() {
                newAccounts.removeAt(index);
              });

              CommAlarmDatabase.instance.delete(newAccount.id!);
            },
            
            background: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: buildNoteCard(newAccount, context, index),
          );
        },
      );

  Widget buildNoteCard(NewAccount newAccount, BuildContext context, index) =>
        
         ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          tileColor: Colors.blueAccent[300],

          leading: Text(
            newAccounts[index].id.toString(),
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
            ),
          ),

          title: Text(
            newAccounts[index].email,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            newAccounts[index].mobileNo,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
              ),
          ),
          trailing:
              const Icon(
                Icons.more_vert_sharp, 
                color: Colors.lightBlueAccent, 
                size: 40),


          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AcctDetailPage(
                
                newAcctId: newAccount.id!,
              ),
            ),);
            refreshNotes();
          },
        );

}