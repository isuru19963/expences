import 'package:flutter/material.dart';
import 'mainDashboard.dart';
import 'allLocalexpenses.dart';
import 'expenseList.dart';
import 'package:Expense/utils/database_helper.dart';
import 'package:Expense/models/note.dart';
import 'package:sqflite/sqflite.dart';

class SyncScreen extends StatefulWidget {
  @override
  _SyncScreenState createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  Note note;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return mainDashboard();
              }));
            }
        ),
        title: Text("Sync Screen"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 15),
              color: Colors.blue,
              height: 60,
              width: 400,
              child: IconButton(
                  icon: Text("Full Sync",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: () {
                    updateListView();
                    // debugPrint("Full sync");
                  }
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 15),
              color: Colors.blue,
              height: 60,
              width: 400,
              child: IconButton(

                  icon: Text("Single Expense Sync",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      // return AllLocalExpense();
                      return LocalExpenseList();
                    }));

                  }
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 15),
              color: Colors.blue,
              height: 60,
              width: 400,
              child: IconButton(
                  icon: Text("Cache Clear",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                  onPressed: () {
                    debugPrint("Cache Clear");
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Note>> expenseListFuture = databaseHelper.getExpenseList();
      expenseListFuture.then((expenseList){
        setState(() {
          this.noteList = expenseList;
          this.count = noteList.length;
          print(this.noteList = expenseList);
        });
      });
    });
  }

}
