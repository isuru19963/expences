//material import start
// import 'dart:convert';

import 'package:Expense/screens/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//material import ends

import  'mainDashboard.dart';
import 'forgot-password.dart';
import 'register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isLoading = false;
  var email;
  var password;
  var mes;
  var testi;
  // TextEditingController uname = TextEditingController();
  // TextEditingController pass = TextEditingController();

  final GlobalKey<FormState> _formData = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {

    Widget _UserName(){
      return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20.0, bottom: 10),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "E-MAIL ADDRESS",
            ),
            // controller: uname,
            validator: (userName){
              if(userName.isEmpty){
                return "Email can't be empty";
              }
              return null;
            },
            onSaved: (userName){
              email = userName;
            },
            style: TextStyle(
                fontSize: 16.0
            ),
          ),
        ),
      );
    }

    Widget _password(){
      return Container(
        child: Padding(
          padding: EdgeInsets.only(right: 20, left: 20.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "PASSWORD",
            ),
            // controller: pass,
            validator: (password){
              if(password.isEmpty){
                return "Pasword can't Be empty";
              }
              return null;
            },
            onSaved: (pass){
              password = pass;
            },
            style: TextStyle(
                fontSize: 16.0
            ),
          ),
        ),
      );
    }

    Future loginFetch() async{
      // setState(() {
      //   mes = "Came Here";
      // });
      var rsp = await loginUser(email, password);
      setState(() {
        testi = "Some wrong";
      });
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      setState(() {
        if(rsp['code'] == 500){
          mes = rsp;
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_){
                return mainDashboard();
              }
          ));

          if(rsp['user']['unique_id'] != null){
            localStorage.setString('user', rsp['user']['unique_id']);
            localStorage.setString('email', rsp['user']['email']);
            localStorage.setString('card_no', rsp['user']['card_no']);
            localStorage.setString('department', rsp['user']['department']);
            localStorage.setString('name', rsp['user']['name']);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_){
                  return mainDashboard();
                }
            ));
          } else {
            testi = "Something Err";
            print("SORRY");
          }
        }
      });
    }

    String Message = '';
    return Scaffold(
      body:Container(
        color: Colors.white,
        child: Form(
          key: _formData,
          child: ListView(
            children: [
              //Header Image Start
              Container(
                child: Image.asset("assest/ex-banner.png",),
              ),
              //Header Image End
              //Email text Field start
              _UserName(),
              // Email text field ends
              // Password text field start
              _password(),
              //Password text field ends
              //Login button start
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, top: 10),
                  child: FlatButton.icon(
                      height: 45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)
                      ),
                      color: Colors.blue,
                      splashColor: Colors.lightBlue,
                      onPressed: () {
                        if(_formData.currentState.validate()){
                          _formData.currentState.save();
                          try{
                            loginFetch();
                          }catch(e){
                            setState(() {
                              mes = e.toString();
                            });
                        }
                        } else {
                          print("Fields are empty");
                        }
                        // loginFetch();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_){
                        //       return mainDashboard();
                        //     }
                        // ));
                      },
                      textColor: Colors.white,
                      icon: Icon(Icons.login),
                      label: Text("LOGIN")
                  ),
                ),
              ),
              //Login Button Ends
              //Footer Section Start
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Message),
                    //forgot password button start
                    TextButton.icon(
                        onPressed: (){
                          showSnackBar(context, "Test");
                          PageNavigation();
                        },
                        icon: Icon(Icons.lock_outlined),
                        label: Text("Forgot Password")
                    ),
                    //forgot password button ends
                    //register button start

                    TextButton.icon(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_){
                                return userRegister();
                              }
                          ));
                        },
                        icon: Icon(Icons.account_circle),
                        label: Text("Register")
                    ),
                    //register button ends
                  ],
                ),
              ),
              //footer image - peercore logo - start
              Container(
                child: Center(
                  child: Image.asset("assest/plogo.png", width: 100.0,),
                ),
              ),
              Container(
                child: Center(
                  child: Text(mes == null ? "" : mes.toString()),
                )
                ),
              Container(
                  child: Center(
                    child: Text(testi == null ? "" : testi.toString()),
                  )
              ),
              //footer image - peercore logo - ends
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message),);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void PageNavigation(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_){
          return forgotPassword();
        }
    ));
  }

}