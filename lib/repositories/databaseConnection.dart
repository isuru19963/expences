import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'expenseDatadb.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabse);
    return database;
  }

  _onCreatingDatabse(Database database, int version) async{
    await database.execute("CREATE TABLE localExpenseData(id INTEGER PRIMARY KEY, amount TEXT, paymentType TEXT, note TEXT, date TEXT, cardNumber TEXT)");
  }
}