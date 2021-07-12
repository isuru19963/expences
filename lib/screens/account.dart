//import all flutter packages start
import 'dart:ui';

import 'package:flutter/material.dart';
//import all flutter packages start

class accountDetails extends StatefulWidget {
  @override
  _accountDetailsState createState() => _accountDetailsState();
}

class _accountDetailsState extends State<accountDetails> {
  @override

  Widget profileImage(){
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage("assest/user_avatar.png"),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomModal()));
              },
              child: Icon(
                Icons.camera,
                color: Colors.blue,
                size: 30,),
            ),

          ),
        ],
      ),
    );
  }

  Widget bottomModal(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: [
          Text("Choose Profile Image",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.camera),
                  label: Text("Image Upload")
              ),
              SizedBox(width: 20,),
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.image), label: Text("Gallery"))
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Account"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            children: [
              profileImage(),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  prefix: Icon(Icons.account_circle),
                  fillColor: Colors.lightBlueAccent,
                  hintText: "First Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  prefix: Icon(Icons.account_circle),
                  fillColor: Colors.lightBlueAccent,
                  hintText: "Last Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  prefix: Icon(Icons.account_circle),
                  fillColor: Colors.lightBlueAccent,
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefix: Icon(Icons.vpn_key),
                  fillColor: Colors.lightBlueAccent,
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefix: Icon(Icons.call_to_action_rounded),
                  fillColor: Colors.lightBlueAccent,
                  hintText: "Card Details",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              FlatButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 60.0,
                  onPressed: (){},
                  icon: Icon(Icons.send),
                  label: Text("Save Profile"))
            ],
          ),
        ),
      ),
    );
  }
}
