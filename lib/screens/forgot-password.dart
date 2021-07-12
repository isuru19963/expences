import 'package:flutter/material.dart';

class forgotPassword extends StatefulWidget {
  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // email.text="dulanjan@gmail.com";
    // String email_getter = email.text;
    return Scaffold(
    //   appBar: AppBar(
    //   title: Text("Forgot Password"),
    // ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 35.0, left: 35.5),
        child: Container(
          // color: Colors.red,
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    // Image.asset("assest/ex-banner.png"),
                    Icon(
                      Icons.account_circle,
                      size: 200.0,
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: email,
                      // validator: ,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0)
                        ),
                        fillColor: Colors.lightBlueAccent,
                        prefixIcon: Icon(
                            Icons.account_circle
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    FlatButton.icon(
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: (){
                          print("Cliked");
                        },
                        icon: Icon(Icons.send),
                        label: Text("Send Mail"))
                  ],

                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
