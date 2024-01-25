import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';

import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';

const String tableNewAccount = 'newAccounts';

// this class is used to create the database and the table in the database
class CommAlarmDatabase {

  // creates static and final instance of CommAlarmDatabase that can be null or not
  // and calls the [_init] method to initialize the database and returns the database to the [instance] getter below 
  static final CommAlarmDatabase instance = CommAlarmDatabase._init();

  // database to send sql commands, created during [openDatabase] call in [_initDB] method
  static Database? _database;

  // private constructor of the CommAlarmDatabase class, so that it can only be instantiated within the class itself (singleton)
  CommAlarmDatabase._init();

  // returns true if it does, false if it doesn't exist yet in the database (for the first time) and creates the table in the database if it doesn't exist
  // this is to prevent the app from crashing when the table doesn't exist in the database
  // this is called in the [readAllNewAccounts] method to check if the table exists in the database
  Future<bool> tableExists(String tableName) async {

  // gets the database instance from the [database] getter below and stores it in the [db] variable below 
    final db = await instance.database;

  // query() : this is where the database is queried to check if the table exists in the database and stores the result in the [tables] variable below
    var tables = await db.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName],
    );
    return tables.isNotEmpty;
  }

  // getter for the database instance that returns the database if it exists, otherwise it creates the database and returns it if it doesn't exist
  // this is called in the [create], [readNewAccount], [readAllNewAccounts], [update], [delete] methods
  Future<Database> get database async {
    if (_database != null) return _database!;

  // if the database doesn't exist, it will call the [_initDB] method to create the database
  // and then it will return the database that was created in the [_initDB] method to the [database] getter above
    _database = await _initDB('commalarmDB.db');
    return _database!;
  }

  // initializes the database and returns it to the [database] getter above to be returned to the 
  // [create], [readNewAccount], [readAllNewAccounts], [update], [delete] methods to be used to create the database in those methods this is called in the [database] getter above 
  Future<Database?> _initDB(String filePath) async {

    // getDatabasesPath() : this is where sqflite gets the path to the database
    // within the app's folder on the device (the path is different for iOS and Android) and stores it in the [dbPath] variable below 
    // the [dbPath] variable is then used in the [join] method to join the path to the database with the file name of the database
    // the [join] method is then stored in the [path] variable below and is returned to the [_initDB] method above
    final dbPath = await getDatabasesPath();

    // join() : this is where the path to the database is joined with the file name of the database to create the full path to the database
    // the full path to the database is then stored in the [path] variable below and is returned to the [database] getter above
    // the [path] variable is then used in the [openDatabase] method to create the database in the [database] getter above
    final path = join(dbPath, filePath);

    // openDatabase() : this is where the database is created and stored in the [db] variable below and is returned to the [_initDB] method above
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  // creates the database and the table in the database and returns it to the [database] getter above to be returned to the 
  // [create], [readNewAccount], [readAllNewAccounts], [update], [delete] methods to be used to create the database in those methods 
  // this is called in the [database] getter above
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableNewAccount (
        ${NewAccountFields.id} $idType,
        ${NewAccountFields.firstName} $textType,
        ${NewAccountFields.lastName} $textType,
        ${NewAccountFields.email} $textType,
        ${NewAccountFields.reEnterPassword} $textType,
        ${NewAccountFields.mobileNo} $integerType,
        ${NewAccountFields.address} $textType,
        ${NewAccountFields.alarmTime} TEXT,
        ${NewAccountFields.estTime} TEXT,
        ${NewAccountFields.readyTimeFinal} TEXT,
        ${NewAccountFields.freqDate} TEXT,
        ${NewAccountFields.startDate} TEXT,
        ${NewAccountFields.endDate} TEXT,
        ${NewAccountFields.orgAddress} TEXT,
        ${NewAccountFields.destAddress} TEXT,
        ${NewAccountFields.commTime} TEXT,
        ${NewAccountFields.calcAlarmTime} TEXT,
        ${NewAccountFields.field1} TEXT,
        ${NewAccountFields.field2} TEXT


      )
      
      ''');
  }

  // inserts a new account into the database and returns the new account to the [create] method to be used to create the new account in the database
  Future<NewAccount> create(NewAccount newAccount) async {

  // gets the database instance from the [database] getter above and stores it in the [db] variable below 
  // the [db] variable is then used in the [rawInsert] method to insert the new account into the database 
  // and then it will return the id of the new account that was inserted in the database to the [create] method above
    final db = await instance.database;

  // rawInsert() : this is where the new account is inserted into the database and the id of the new account is returned to the [create] method above
  // the [rawInsert] method is then stored in the [id] variable below and is returned to the [create] method above
    final columns =
        ('${NewAccountFields.firstName}, ${NewAccountFields.lastName}, ${NewAccountFields.email}, ${NewAccountFields.reEnterPassword}, ${NewAccountFields.mobileNo}, ${NewAccountFields.address},${NewAccountFields.alarmTime}, ${NewAccountFields.estTime}, ${NewAccountFields.readyTimeFinal}, ${NewAccountFields.freqDate}, ${NewAccountFields.startDate}, ${NewAccountFields.endDate}, ${NewAccountFields.orgAddress}, ${NewAccountFields.destAddress}, ${NewAccountFields.commTime}, ${NewAccountFields.calcAlarmTime}, ${NewAccountFields.field1}, ${NewAccountFields.field2}');

    final values =
        ('${jsonEncode(newAccount.firstName)}, ${jsonEncode(newAccount.lastName)}, ${jsonEncode(newAccount.email)}, ${jsonEncode(newAccount.reEnterPassword)}, ${jsonEncode(newAccount.mobileNo)}, ${jsonEncode(newAccount.address)}, ${jsonEncode(newAccount.alarmTime)}. ${jsonEncode(newAccount.estTime)}, ${jsonEncode(newAccount.readyTimeFinal)}, ${jsonEncode(newAccount.freqDate)}, ${jsonEncode(newAccount.startDate)}, ${jsonEncode(newAccount.endDate)}, ${jsonEncode(newAccount.orgAddress)}, ${jsonEncode(newAccount.destAddress)}, ${jsonEncode(newAccount.commTime)}, ${jsonEncode(newAccount.calcAlarmTime)}, ${jsonEncode(newAccount.field1)}, ${jsonEncode(newAccount.field2)}');

    // final id = await db 
    // .rawInsert('INSERT INTO $tableNewAccount ($columns) VALUES ($values)');

    // create the table if it doesn't exist yet in the database 
    bool tableExists = await this.tableExists(tableNewAccount);
    if (!tableExists) {
      await _createDB(db, 2);
    }
    // insert the new account into the database and 
    // return the id of the new account that was inserted in the database to the [create] method above
    final id = await db.insert(tableNewAccount, newAccount.toJson());
    return newAccount.copy(id: id);
  }

  // reads a new account from the database and returns the new account to the [readNewAccount] method 
  // to be used to read the new account from the database in the [readNewAccount] method
  // this is called in the [readAllNewAccounts] method to read all new accounts from the database
  Future<NewAccount> readNewAccount(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNewAccount,
      columns: NewAccountFields.values,
      where: '${NewAccountFields.id} = ?',
      //within whereArgs, the id is the value that is being searched for
      //and the ? is the placeholder for the value
      //so if you add in more values to search for, you would add more ?s
      whereArgs: [id],
    );

    // if the new account exists in the database, it will return the new account to the [readNewAccount] method above
    // otherwise it will throw an exception
    if (maps.isNotEmpty) {
      return NewAccount.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // reads all new accounts from the database and returns the list of new accounts to the [readAllNewAccounts] method
  // to be used to read all new accounts from the database in the [readAllNewAccounts] method
  // this is called in the [readAllNewAccounts] method to read all new accounts from the database
  Future<List<NewAccount>> readAllNewAccounts() async {

    // gets the database instance from the [database] getter above and stores it in the [db] variable below
    // the [db] variable is then used in the [query] method to query the database to read all new accounts from the database
    // and then it will return the list of new accounts that was read from the database to the [readAllNewAccounts] method above
    final db = await instance.database;

    // create the table if it doesn't exist yet in the database 
    bool tableExists = await this.tableExists(tableNewAccount);
    if (!tableExists) {
      await _createDB(db, 2);
    }

    // orderBy: '${NewAccountFields.lastName} ASC' : this is where the new accounts are ordered by last name in ascending order
    // the [orderBy] variable is then stored in the [orderBy] variable below and is returned to the [readAllNewAccounts] method above
    final orderBy = '${NewAccountFields.lastName} ASC';

    final result = await db.query(tableNewAccount, orderBy: orderBy);

    return result.map((json) => NewAccount.fromJson(json)).toList();
  }

  // updates a new account in the database
  Future<int> update(NewAccount newAccount) async {
    final db = await instance.database;

    return db.update(
      tableNewAccount,
      newAccount.toJson(),
      where: '${NewAccountFields.id} = ?',
      whereArgs: [newAccount.id],
    );
  }

  // deletes a new account from the database
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNewAccount,
      where: '${NewAccountFields.id} = ?',
      whereArgs: [id],
    );
  }

  read(NewAccount id) {}

  // Future close() async {
  //   final db = await instance.database;

  //   db.close();
  // }

  // static Future<void> resetCommAlarmDatabase() async {
  //   final db = await instance.database;

  //   await db.delete(tableNewAccount);
  // }
}
