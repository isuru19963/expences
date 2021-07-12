import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:Expense/models/note.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper; // Singleton DatabaseHepler
  static Database _databse;

  String transactionTable = 'Transaction_table';
  String colId = 'id';
  // String colOriginator = 'originator';
  // String colOriginatorUnique = 'originator_unique';
  String colAmount = 'amount';
  String colTransType = 'transType';
  String colNote = 'note';
  String colEmail = 'email';
  String colPayDate = 'payDate';
  String colCardNo = 'cardNo';
  String colPayProof = 'payProof';
  String colEmpClient = 'empClient';
  String colClient = 'client';
  String colEmployee = 'employee';
  String colDepartment = 'department';
  String colGst = 'gst';
  String colTraveling = "traveling";
  String colEntertainment = "entertainment";
  String colNoneEntertainment = "noneEntertainment";

  // String colPayType = 'pay_type';
  // String colFilePath = 'file_path';
  // String colStatus = 'status';
  // String colCreateDate = 'createDate';

  DatabaseHelper._createInstance(); //Named constructor to create instance of databaseHelper

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_databse == null){
      _databse = await initializeDatabase();
    }
    return _databse;
  }

  Future<Database> initializeDatabase() async{
    //Get the directory path for both Android and IOs Store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'localTransaction.db';

    //open/create the path tadabase at a given path
    var transactionDatabase = await openDatabase(path, version: 1,onCreate: _createDb);
    return transactionDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $transactionTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colAmount TEXT, $colEmail TEXT, $colTransType TEXT, $colCardNo TEXT, $colPayDate TEXT,  $colNote TEXT, $colPayProof BLOB, $colEmpClient TEXT, $colClient TEXT, $colEmployee TEXT, $colDepartment TEXT, $colGst TEXT, $colTraveling TEXT, $colEntertainment TEXT, $colNoneEntertainment)');
  }

  //Fetch Operation: Get all expense object from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;
    var result = await db.query(transactionTable, orderBy: '$colId ASC');
    return result;
  }

//Insert Operation: Insert a transaction to database
  Future<int> insertTransaction(Note note) async{
    Database db = await this.database;
    var result = await db.insert(transactionTable, note.toMap());
    return result;
  }


//Update Operation: Update a note object and save it to datbase
  Future<int> updateTrtansaction(Note note) async{
    Database db = await this.database;
    var result = db.update(transactionTable, note.toMap(), where: '$colId = ?',whereArgs: [note.id]);
    return result;
  }

//Delete Operation: Dlete a transaction object from database
  Future<int> deleteTransaction(int id) async{
    Database db = await this.database;
    var result = db.delete('$transactionTable WHERE $colId = $id');
    return result;
  }

//Get Number of transaction object in database
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT * FROM $transactionTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getExpenseList() async{
    var expenseMapList = await getNoteMapList();
    int count = expenseMapList.length;

    List<Note> expenseList = List<Note>();
    for(int i = 0; i < count; i++){
      expenseList.add(Note.fromMapObject(expenseMapList[i]));
    }
    return expenseList;
  }

}