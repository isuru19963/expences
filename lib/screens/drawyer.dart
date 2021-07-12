import 'package:flutter/material.dart';
// import '../dashBoard.dart';
// import '../productsCategory.dart';
// import '../todaysOrders.dart';
// import '../makeOder.dart';
// import '../outstanding.dart';
// import '../invoiceSettlement.dart';
import 'package:Expense/screens/login.dart';
import 'syncScreen.dart';
import 'account.dart';
import 'mainDashboard.dart';
import 'addTransactions.dart';
import 'package:Expense/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  MainDrawerState createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {

  var name;
  var mail;

  shareDate() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var unique_id = localStorage.getString('user');
    var u_email = localStorage.getString('email');
    var u_name = localStorage.getString('name');
    setState(() {
      name = u_name;
      mail = u_email;
    });
  }


  @override

  void initState(){
    super.initState();
    shareDate();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(30.0),
            color: Colors.lightBlue,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage('https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),fit: BoxFit.cover),
                  ),
                ),
                Text(name.toString(),
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Text(mail.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Dashboard",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return mainDashboard();
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.speaker_notes_outlined),
            title: Text("Add Transaction", style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return addTransaction(Note('','','','','','','','',''),"Add Expense");
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.sticky_note_2_outlined),
            title: Text("Sync", style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return SyncScreen();
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp),
            title: Text("Report",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    // return outStanding();
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Account",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return accountDetails();
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return MyHomePage();
                  }
              ))
            },
          ),
        ],
      ),
    );
  }
}
