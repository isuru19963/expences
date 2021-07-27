//all flutter material imports start
import 'dart:convert';
import 'dart:ui';

import 'package:Expense/models/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account.dart';
import 'addTransactions.dart';
import 'api.dart';
import 'editTransaction.dart';
//all flutter local imports start
import 'login.dart';
//all flutter local imports start
import 'drawyer.dart';
import 'syncScreen.dart';

class mainDashboard extends StatefulWidget {
  @override
  _mainDashboardState createState() => _mainDashboardState();
}

class _mainDashboardState extends State<mainDashboard> {
  int _currentIndex = 1;
  final dateFormat = DateFormat("yyyy/MM/dd");


  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_active_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(child: Text("This Month")),
                Tab(child: Text("last Month")),
                Tab(child: Text("Mar - 2021")),
                Tab(child: Text("Feb - 2021")),
                Tab(child: Text("Jan - 2021")),
                Tab(child: Text("Dec - 2020")),
                Tab(child: Text("Nov - 2020")),
                Tab(child: Text("Oct - 2020")),
              ],
            ),
          ),
          drawer: MainDrawer(),
           body: Container(
            child: TabBarView(
              children: [
                Container(
                  child: FutureBuilder<List<dynamic>>(
                      future: fetchDataList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(snapshot.data[index]['pay_date'].toString());
                                return Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.lightBlue,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Column(
                                    children: [
                                      // Divider(),
                                      Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Container(
                                          child: ListTile(
                                            leading: Text(
                                              snapshot.data[index]['trans_id'].toString(),
                                              style: TextStyle(fontSize: 20),

                                            ),
                                            title: Text(
                                              // DateFormat.y().format(DateTime.now()),
                                              snapshot.data[index]['pay_date'].toString(),
                                              //DateFormat.yMMMd().format(DateTime.tryParse(snapshot.data[index]['pay_date'])),
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            // subtitle: Text(
                                            //   "test",
                                            //   style: TextStyle(fontSize: 15),
                                            // ),
                                            trailing: Text(
                                              snapshot.data[index]['note'].toString(),
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Container(
                                          child: ListTile(
                                            // leading: Icon(
                                            //   Icons.add_moderator,
                                            //   color: Colors.blue,
                                            // ),
                                            leading:GestureDetector(
                                              child: Image(
                                                //Image.asset("assest/plogo.png", width: 100.0,)
                                                image: NetworkImage('https://www.printablesample.com/wp-content/uploads/2017/03/atm-receipt-1.jpg'),
                                              ),
                                              onTap: (){
                                                // _showAlert();
                                              },
                                            ),
                                            title: Text(
                                              snapshot.data[index]['trans_type'].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data[index]['amount'].toString(),
                                                  style: TextStyle(fontSize: 20,color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )
                                            // onTap: (){
                                            //   Navigator.push(context,
                                            //       MaterialPageRoute(builder: (context){
                                            //         return editTransaction(snapshot.data[index]['trans_id']);
                                            //   }));
                                            // },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
                Container(
                    child: Center(
                      child: Text("There are no any Expense in this Month"),
                    )),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return addTransaction(Note('','','','','','','','',''),"Add Expense");
                  }
              ));
            },
            // elevation: 6,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 4.0,
            color: Colors.transparent,
            elevation: 9.0,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)
                  ),
                  color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width /2 - 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.account_balance_wallet_rounded, color: Colors.blue),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return addTransaction(Note('','','','','','','','',''),"Add Expense");
                            }));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.pie_chart_outline_outlined, color: Colors.blue),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return addTransaction(Note('','','','','','','','',''),"Add Expense");
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width /2 - 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(Icons.cached_rounded, color: Colors.blue),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                return SyncScreen();
                              }));
                            }
                        ),
                        IconButton(
                          icon: Icon(Icons.account_circle_rounded, color: Colors.blue),
                          onPressed: (){
                            // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            //   return accountDetails();
                            // }));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  fetchData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    var card = localStorage.getString('user');
    // var data = {
    //   'ophthalmologist-prescription-draft-id':prescription_draft_id,
    //   'doctor_id' :widget.doctorID,
    // };
    // var rsp = await loginUser(data);
    // print(user);
  }

  Future<List<dynamic>> fetchDataList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('email');
    var unique_id = localStorage.getString('user');
    print(unique_id);

    var data = {
      "originator_unique": unique_id,
      "date_from": '01-01-17',
      "date_to": '12-12-21'
    };
    var res = await getList(data);
    var details=json.decode(res.body)['details'];
    return json.decode(res.body)['details'];
  }


  void initState() {
    super.initState();
    fetchDataList();
    fetchData();
  }

  _showAlert(){
    AlertDialog alertDialog = AlertDialog(
      // title: Text(status),
      content: Image(
        //Image.asset("assest/plogo.png", width: 100.0,)
        image: NetworkImage('https://www.printablesample.com/wp-content/uploads/2017/03/atm-receipt-1.jpg'),
      ),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}
