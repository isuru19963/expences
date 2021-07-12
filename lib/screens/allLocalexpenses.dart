import 'dart:ui';
import 'dart:async';
import 'package:Expense/utils/database_helper.dart';
import 'package:Expense/models/note.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'syncScreen.dart';

class AllLocalExpense extends StatefulWidget {
  @override
  _AllLocalExpenseState createState() => _AllLocalExpenseState();
}

class _AllLocalExpenseState extends State<AllLocalExpense> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;

  int rowCount = 1;

  _showFormDilaog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder:(param){
      return AlertDialog(
        // elevation: 10.0,
        actions: [
          FlatButton(
            color: Colors.red,
            onPressed: () =>
                Navigator.pop(context),
            child: Text("Cancel"),
          ),
          FlatButton(
            color: Colors.green,
            onPressed: (){},
            child: Text("Delete"),
          )
        ],
        title: Center(
          child: Text("Are you sure to delete this?", style: TextStyle(fontSize: 16),),
        ),
      );
    });
  }

  _updateExpense(BuildContext context){
    return showDialog(barrierDismissible: true, context: context, builder: (params){
      return AlertDialog(
        title: Text("Update Expense", style: TextStyle(fontSize: 16),),
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel"),
            color: Colors.red,
          ),
          FlatButton(
            onPressed: (){
              print('TEST');
            },
            child: Text("Update"),
            color: Colors.green,
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Amount",
                    labelText: "Amount"
                ),
                keyboardType: TextInputType.number,
                //controller: _amount,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Payment Type",
                    labelText: "Payment Type"
                ),
                //controller: _paymentType,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Note",
                    labelText: "Note"
                ),
                //controller: _note,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Date",
                    labelText: "Date"
                ),
                //controller: _date,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Card Number",
                    labelText: "Card Number"
                ),
                //controller: _cardNumber,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget LocalData(){
    return Container(
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.wb_sunny,),
                ),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('SYNC THIS ONE', style: TextStyle(color: Colors.green, fontSize: 12.0),),
                    onPressed: () {
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('UPDATE', style: TextStyle(color: Colors.blue, fontSize: 12.0),),
                    onPressed: () {
                      _updateExpense(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('DELETE', style: TextStyle(color: Colors.red, fontSize: 12.0),),
                    onPressed: () {
                      _showFormDilaog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(noteList == null){
      noteList = List<Note>();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Non Synced Expense"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return SyncScreen();
                }));
              }
          ),
        ),
        body:ListView.builder(
          itemCount: rowCount,
          itemBuilder: (BuildContext context, int index){
            return Column(
              children: [
                // LocalData()
                Container(
                  child: Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: CircleAvatar(
                              // backgroundColor: this.noteList[index].id,
                              child: Icon(Icons.wb_sunny,),
                            ),
                            title: Text('The Enchanted Nightingale'),
                            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('SYNC THIS ONE', style: TextStyle(color: Colors.green, fontSize: 12.0),),
                                onPressed: () {
                                },
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                child: const Text('UPDATE', style: TextStyle(color: Colors.blue, fontSize: 12.0),),
                                onPressed: () {
                                  _updateExpense(context);
                                },
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                child: const Text('DELETE', style: TextStyle(color: Colors.red, fontSize: 12.0),),
                                onPressed: () {
                                  _showFormDilaog(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        )
    );
  }

  //Return the Colors
  Color getIconColor(int id){
    switch(id){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.indigo;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.blue;
    }
  }
  //Return the Icon
  Icon getIconForTransType(int transType){
    switch(transType){
      case 1:
        return Icon(Icons.payments_outlined);
        break;
      case 2:
        return Icon(Icons.email);
        break;
      case 3:
        return Icon(Icons.payments);
        break;
      case 4:
        return Icon(Icons.message);
        break;
      default :
        return Icon(Icons.verified);
    }
  }

  void _delete(BuildContext context, Note note) async{
    int result = await databaseHelper.deleteTransaction(note.id);
    if(result != 0){
      _showSnackBar(context, "Transaction Deleted Successfully");
    }
  }

  void _showSnackBar(BuildContext context, String message){

    final snackBar = SnackBar(content: Text(message),);
    Scaffold.of(context).showSnackBar(snackBar);

  }

}