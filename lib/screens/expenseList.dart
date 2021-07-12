import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Expense/utils/database_helper.dart';
import 'package:Expense/models/note.dart';
import 'package:Expense/screens/addTransactions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class LocalExpenseList extends StatefulWidget {
  @override
  _LocalExpenseListState createState() => _LocalExpenseListState();
}

class _LocalExpenseListState extends State<LocalExpenseList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  Note note;
  var selPayDate;

  PickedFile _expenceproof;

  @override
  Widget build(BuildContext context) {

    if(noteList== null){
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Local Data'),
      ),
      body: getLocalDataListView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          navigateToDetail(Note('','','','','','','','',''),'Ad Expense');
        },
      ),
    );
  }

  ListView getLocalDataListView(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        selPayDate = this.noteList[position].payDate;
        print(this.noteList[position].payProof);
        return Container(
          child: Card(
            color: Colors.white,
            elevation: 2.0,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: getColor(this.noteList[position].id),
                    child: Image(image: AssetImage('assest/billdummy.jpg',)),
                    // child: getIcon(this.noteList[position].id),
                  ),
                  title: Text(this.noteList[position].amount+" - GST :"+this.noteList[position].gst),
                  // title: Text(this.noteList[position].cardNo),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.noteList[position].payDate, style: TextStyle(fontSize: 12.0,),),
                      Text(this.noteList[position].transType, style: TextStyle(fontSize: 16.0, color: Colors.black),),
                    ],
                  ),
                  // subtitle: Text(this.noteList[position].payDate),
                  trailing: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      //Text(this.noteList[position].note),
                      Text(this.noteList[position].note),
                      Text(this.noteList[position].empClient,
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                      // Text(this.noteList[position].employee),
                      // Text(this.noteList[position].client),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Text(this.noteList[position].payProof),
                    // Text(this.noteList[position].client),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('SYNC THIS ONE', style: TextStyle(color: Colors.green, fontSize: 12.0),),
                      onPressed: () async{
                        _showAlertDialogUntillUpdate(context, "Wait.. Syncing");
                        Navigator.pop(context);
                        await postTransaction(this.noteList[position].amount.toString(), this.noteList[position].payDate, this.noteList[position].note, this.noteList[position].transType, this.noteList[position].payProof ,this.noteList[position].client, this.noteList[position].employees, this.noteList[position].empClient, this.noteList[position].department, this.noteList[position].gst, this.noteList[position].traveling, this.noteList[position].entertainment, this.noteList[position].noneEntertainment);
                        _syncUpdate(context, this.noteList[position]);
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('UPDATE', style: TextStyle(color: Colors.blue, fontSize: 12.0),),
                      onPressed: () {
                        // _updateExpense(context);
                        navigateToDetail(this.noteList[position],"Edit Expense");
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('DELETE', style: TextStyle(color: Colors.red, fontSize: 12.0),),
                      onPressed: () {
                        // _showFormDilaog(context);
                        _delete(context, this.noteList[position]);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color getColor(int transType){
    switch(transType){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.pink;
        break;
      case 4:
        return Colors.blue;
        break;
      default:
        return Colors.black;
    }
  }

  Icon getIcon(int transType){
    switch(transType){
      case 1:
        return Icon(Icons.arrow_back);
        break;
      case 2:
        return Icon(Icons.build);
        break;
      case 3:
        return Icon(Icons.email);
        break;
      case 4:
        return Icon(Icons.verified);
        break;
      default:
        return Icon(Icons.verified);
    }
  }

  void _delete(BuildContext context, Note note) async{

    int result = await databaseHelper.deleteTransaction(note.id);
    if(result != 0){
      _showSnacBar(context, 'Expense Deleted Successfully');
      updateListView();
    }
  }

  void _syncUpdate(BuildContext context, Note note) async{

    int result = await databaseHelper.deleteTransaction(note.id);
    if(result != 0){
      updateListView();
    }
  }

  _showSnacBar(BuildContext context, String message){

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);

  }

  _loader(BuildContext context, String message){

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);

  }

  void navigateToDetail(Note note, String title)async{
    bool result = await Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return addTransaction(note,title);
        }
    ));

    if(result == true){
      updateListView();
    }
  }

  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Note>> expenseListFuture = databaseHelper.getExpenseList();
      expenseListFuture.then((expenseList){
        setState(() {
          this.noteList = expenseList;
          this.count = noteList.length;
        });
      });
    });
  }

  void postTransaction(String amount, String pay_date, String note, String payType, String payProof, String client, String employee, String empClient, String department, String gst, String traveling, String entertainment, String noneEntertainment) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('email');
    var unique_id = localStorage.getString('user');
    var u_card_no = localStorage.getString('card_no');
    print(pay_date);
    print(payProof);

    if(_expenceproof == null){
      //_showAlertDialog(context, "No such a image added");
      //return;
    } else {
      String image = _expenceproof.path;
      final bytes = await Io.File(_expenceproof.path).readAsBytes();
      print(bytes);
      print(image);
      // String img64 = base64Encode(bytes);
    }

    var data = [
      {
        "originator":"1",
        "originator_unique": unique_id,
        "email": user,
        "trans_type": payType,
        "amount":amount,
        "pay_type": payType,
        "card_no":u_card_no,
        "pay_date": pay_date,
        "note":note,
        "pay_proof":"payProof",
        "filepath":"",
        "status": "N",
        "emp_client": empClient,
        "no_employees": client,
        "no_clients": employee,
        "originator_state": "sample string 17",
        "originator_department": department,
        "gst": gst,
        "no_travelling": traveling,
        "no_entertainment": entertainment,
        "no_nonentertainment": noneEntertainment
      }
    ];

    var rsp = await PostTransactionApi(data);
    print(data);
    if(rsp == null){
      print("null");
    } else {
      print(rsp);
      print(pay_date);
      _showAlertDialog(context, "Data Synchronization Completed");
      // _delete(context,);

    }
  }

  void _showAlertDialog(context, String mess){
    AlertDialog alertDialog = AlertDialog(
      title: Text("Successfully Synced ", style: TextStyle(fontSize: 12.2, color: Colors.green),),
      content: Text(mess),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

  void _showAlertDialogUntillUpdate(context, String mess){
    AlertDialog alertDialog = AlertDialog(
      title: Text("Just Wait... ", style: TextStyle(fontSize: 12.2, color: Colors.green),),
      content: Text(mess),
    );
    showDialog(

        context: context,
        // barrierDismissible: false,
        builder: (_) => alertDialog
    );
  }

}