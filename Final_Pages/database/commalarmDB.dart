// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:async';
// import 'dart:convert';


// import 'package:commalarm_app/testing/models/newAccountModel.dart';




// const String tableNewAccount = 'newAccounts';


// class CommAlarmDatabase {
//   static final CommAlarmDatabase instance = CommAlarmDatabase._init();
//   static Database? _database;


//   CommAlarmDatabase._init();



//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('commalarm.db');
//     return _database!;
//   }

//   Future<Database?> _initDB(String filePath) async {
//     // getDatabasesPath() : this is where sqflite gets the path to the database 
//     // within the app's folder on the device. 
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(path, version: 2, onCreate: _createDB);

//   }


//   Future _createDB(Database db, int version) async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';
//     const integerType = 'INTEGER NOT NULL';

//     await db.execute('''
//       CREATE TABLE $tableNewAccount (
//         ${NewAccountFields.id} $idType,
//         ${NewAccountFields.firstName} $textType,
//         ${NewAccountFields.lastName} $textType,
//         ${NewAccountFields.email} $textType,
//         ${NewAccountFields.reEnterPassword} $textType,
//         ${NewAccountFields.mobileNo} $integerType,
//         ${NewAccountFields.address} $textType,
//         ${NewAccountFields.alarmTime} TEXT,
//         ${NewAccountFields.estTime} TEXT

//       )
      
//       ''');
//   }



//   Future<NewAccount> create(NewAccount newAccount) async {
//     final db = await instance.database;

//     final columns = 
//     ('${NewAccountFields.firstName}, ${NewAccountFields.lastName}, ${NewAccountFields.email}, ${NewAccountFields.reEnterPassword}, ${NewAccountFields.mobileNo}, ${NewAccountFields.address},${NewAccountFields.alarmTime}, ${NewAccountFields.estTime}'); 

//     final values = 
//     ('${jsonEncode(newAccount.firstName)}, ${jsonEncode(newAccount.lastName)}, ${jsonEncode(newAccount.email)}, ${jsonEncode(newAccount.reEnterPassword)}, ${jsonEncode(newAccount.mobileNo)}, ${jsonEncode(newAccount.address)}, ${jsonEncode(newAccount.alarmTime)}. ${jsonEncode(newAccount.estTime)}');

//     // final id = await db
//       // .rawInsert('INSERT INTO $tableNewAccount ($columns) VALUES ($values)');
  
      
//       final id = await db.insert(tableNewAccount, newAccount.toJson());
//       return newAccount.copy(id: id);
//     }




//   Future<NewAccount> readNewAccount(int id) async {
//     final db = await instance.database;

//     final maps = await db.query(
//       tableNewAccount,
//       columns: NewAccountFields.values,
//       where: '${NewAccountFields.id} = ?',
//       //within whereArgs, the id is the value that is being searched for
//       //and the ? is the placeholder for the value
//       //so if you add in more values to search for, you would add more ?s
//       whereArgs: [id],
//     );

//     if (maps.isNotEmpty) {
//       return NewAccount.fromJson(maps.first);
//     } else {
//       throw Exception('ID $id not found');
//     }
//   }


//   Future<List<NewAccount>> readAllNewAccounts() async {
//     final db = await instance.database;

//     final orderBy = '${NewAccountFields.lastName} ASC';

//     final result = await db.query(tableNewAccount, orderBy: orderBy);

//     return result.map((json) => NewAccount.fromJson(json)).toList();
//   }


//   Future<int> update(NewAccount newAccount) async {
//     final db = await instance.database;

//     return db.update(
//       tableNewAccount,
//       newAccount.toJson(),
//       where: '${NewAccountFields.id} = ?',
//       whereArgs: [newAccount.id],
//     );
//   }

//   Future<int> delete(int id) async {
//     final db = await instance.database;

//     return await db.delete(
//       tableNewAccount,
//       where: '${NewAccountFields.id} = ?',
//       whereArgs: [id],
//     );
//   }

//   read(NewAccount id) {
    
//   }


//   // Future close() async {
//   //   final db = await instance.database;

//   //   db.close();
//   // }

//   // static Future<void> resetCommAlarmDatabase() async {
//   //   final db = await instance.database;

//   //   await db.delete(tableNewAccount);
//   // }
// }