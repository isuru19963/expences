import 'dart:ui';

//import 'package:Expense/modules/expense.dart';
//import 'package:Expense/services/expenseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:Expense/utilities/Database_helper.dart';
import 'syncScreen.dart';

class AllLocalExpense extends StatefulWidget {
  @override
  _AllLocalExpenseState createState() => _AllLocalExpenseState();
}

class _AllLocalExpenseState extends State<AllLocalExpense> {

  var items = List<String>.generate(10, (index) => "Item $index");
  // int amount;
  // String Payment_Type;
  // String Note;
  // String Date;
  // int Card_number;

  var _amount = TextEditingController();
  var _paymentType = TextEditingController();
  var _note = TextEditingController();
  var _date = TextEditingController();
  var _cardNumber = TextEditingController();

  // var _expenses = Expense();
  // var _allServices = AllServices();


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
              // _expenses.amount = _amount.text;
              // _expenses.paymentType = _paymentType.text;
              // _expenses.note = _note.text;
              // _expenses.date= _date.text;
              // _expenses.cardNumber = _cardNumber.text;
              //
              // _allServices.saveExpense(_expenses);
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
                controller: _amount,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Payment Type",
                    labelText: "Payment Type"
                ),
                controller: _paymentType,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Note",
                    labelText: "Note"
                ),
                controller: _note,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Date",
                    labelText: "Date"
                ),
                controller: _date,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Card Number",
                    labelText: "Card Number"
                ),
                controller: _cardNumber,
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
                leading: Icon(Icons.album),
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

  initState(){
    super.initState();
    print("TEST");
    // DataList();
  }

  Widget build(BuildContext context) {
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
          itemCount:items.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
              children: [
                // Text(items[index]),
                LocalData()
              ],
            );
          },
        )
    );
  }
}