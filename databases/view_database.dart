// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:commalarm_app/models/traffic_data_model.dart';
import 'package:commalarm_app/databases/database_helper.dart';


void main() {
  runApp(const MaterialApp(
    home: DBDataList(),
  ));
}

class DBDataList extends StatefulWidget {
  const DBDataList({Key? key}) : super(key: key);

  @override
  _DBDataListState createState() => _DBDataListState();
}

class _DBDataListState extends State<DBDataList> {
  List<DBDataModel> dbDataList = [];


  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          AlertDialog(
            title: const Text('Traffic Data List'),
            content: SizedBox(
              height: 300,
              width: 300,
              child:
                FutureBuilder<List<DBDataModel>>(
                  future: DataBaseHelper.getAllData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].origin),
                            subtitle: Text(snapshot.data![index].destination),
                            trailing: Text(snapshot.data![index].durationInTraffic),
                            );
                          },
                        );
                        } else {
                          return const Center(
                            child: Text('No data found')
                            );
                          }
                        },

                          ),
                        ),
                      ),
                  ElevatedButton(
                    onPressed: () {
                      DataBaseHelper.deleteAllData();
                    },
                    child: const Text('Delete All'),
                  ),
                ],);
            }
          }