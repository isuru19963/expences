// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import  'api.dart';

class userRegister extends StatefulWidget {
  @override
  _userRegisterState createState() => _userRegisterState();
}

class _userRegisterState extends State<userRegister> {

  PickedFile _imagePicker;
  final ImagePicker _picker = ImagePicker();
  TextEditingController userName = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget imageProfile(){
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
              radius: 80.0,
              backgroundImage: _imagePicker == null ? AssetImage("assest/user_avatar.png") : FileImage(File(_imagePicker.path))
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                );
              },
              child:  Icon(
                Icons.camera_alt,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(){
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
            style: TextStyle(fontSize: 20.0)
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.camera);
                },
                icon:Icon(Icons.camera_alt),
                label: Text("Camera"),
              ),
              SizedBox(width: 20,),
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery")
              )
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source
    );
    setState(() {
      _imagePicker = pickedFile;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            children: [
              // imageProfile(),
              // SizedBox(height: 20.0,),
              // Icon(
              //   Icons.account_circle,
              //   size: 200.0,
              //   color: Colors.blue,
              // ),
              // SizedBox(height: 20,),
              // TextField(
              //   decoration: InputDecoration(
              //     prefix: Icon(Icons.account_circle),
              //     fillColor: Colors.lightBlueAccent,
              //     hintText: "First Name",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(100.0)
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20.0),
              // TextField(
              //   decoration: InputDecoration(
              //     prefix: Icon(Icons.account_circle),
              //     fillColor: Colors.lightBlueAccent,
              //     hintText: "Last Name",
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(100.0)
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20.0),
              TextField(
                controller: userName,
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
                controller: userPassword,
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
              FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)
                ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 60.0,
                  onPressed: () async {
                    String user = userName.text;
                    String password = userPassword.text;

                    // print("here goes : $user : $password");
                    //
                    // print(user);
                    // print(password);

                    var USL = await registrationUser(user, password);
                    print(USL);
                    var UMESS = USL['message'].toString();
                    if(USL['code'] == 200){
                      showAlertBox(context, "Please Contact Your Administrator.", "Registered.. !");
                    } else {
                      showAlertBox(context, UMESS, "Error !!");
                    }

                    // print(registerDetails);
                  },
                  icon: Icon(Icons.send),
                  label: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
  void showAlertBox(context, String mess, String status){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(status),
          content: new Text(mess),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
