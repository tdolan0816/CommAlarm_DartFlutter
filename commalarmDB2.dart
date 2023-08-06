import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';

import 'package:commalarm_app/Final_Pages/models/newAccountModel.dart';

const String tableNewAccount = 'newAccounts';

class CommAlarmDatabase {
  // creates static and final instance of CommAlarmDatabase that can be null or not
  static final CommAlarmDatabase instance = CommAlarmDatabase._init();
  static Database? _database;

  // private constructor of the CommAlarmDatabase class, so that it can only be instantiated within the class itself (singleton)
  CommAlarmDatabase._init();

  // checks if the table exists in the database
  Future<bool> tableExists(String tableName) async {
    final db = await instance.database;
    var tables = await db.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName],
    );

    return tables.isNotEmpty;
  }

  // getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('commalarmDB.db');
    return _database!;
  }

  // initializes the database
  Future<Database?> _initDB(String filePath) async {
    // getDatabasesPath() : this is where sqflite gets the path to the database
    // within the app's folder on the device.
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  // creates the database
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

  // inserts a new account into the database
  Future<NewAccount> create(NewAccount newAccount) async {
    final db = await instance.database;

    final columns =
        ('${NewAccountFields.firstName}, ${NewAccountFields.lastName}, ${NewAccountFields.email}, ${NewAccountFields.reEnterPassword}, ${NewAccountFields.mobileNo}, ${NewAccountFields.address},${NewAccountFields.alarmTime}, ${NewAccountFields.estTime}, ${NewAccountFields.readyTimeFinal}, ${NewAccountFields.freqDate}, ${NewAccountFields.startDate}, ${NewAccountFields.endDate}, ${NewAccountFields.orgAddress}, ${NewAccountFields.destAddress}, ${NewAccountFields.commTime}, ${NewAccountFields.calcAlarmTime}, ${NewAccountFields.field1}, ${NewAccountFields.field2}');

    final values =
        ('${jsonEncode(newAccount.firstName)}, ${jsonEncode(newAccount.lastName)}, ${jsonEncode(newAccount.email)}, ${jsonEncode(newAccount.reEnterPassword)}, ${jsonEncode(newAccount.mobileNo)}, ${jsonEncode(newAccount.address)}, ${jsonEncode(newAccount.alarmTime)}. ${jsonEncode(newAccount.estTime)}, ${jsonEncode(newAccount.readyTimeFinal)}, ${jsonEncode(newAccount.freqDate)}, ${jsonEncode(newAccount.startDate)}, ${jsonEncode(newAccount.endDate)}, ${jsonEncode(newAccount.orgAddress)}, ${jsonEncode(newAccount.destAddress)}, ${jsonEncode(newAccount.commTime)}, ${jsonEncode(newAccount.calcAlarmTime)}, ${jsonEncode(newAccount.field1)}, ${jsonEncode(newAccount.field2)}');

    // final id = await db
    // .rawInsert('INSERT INTO $tableNewAccount ($columns) VALUES ($values)');
    bool tableExists = await this.tableExists(tableNewAccount);
    if (!tableExists) {
      await _createDB(db, 2);
    }
    final id = await db.insert(tableNewAccount, newAccount.toJson());
    return newAccount.copy(id: id);
  }

  // reads a new account from the database
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

    if (maps.isNotEmpty) {
      return NewAccount.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // reads all new accounts from the database
  Future<List<NewAccount>> readAllNewAccounts() async {
    final db = await instance.database;

    bool tableExists = await this.tableExists(tableNewAccount);
    if (!tableExists) {
      await _createDB(db, 2);
    }

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
