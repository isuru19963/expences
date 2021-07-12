import 'package:flutter/material.dart';

class MainTest extends StatefulWidget {
  @override
  _MainTestState createState() => _MainTestState();
}

class _MainTestState extends State<MainTest> {

  final GlobalKey<FormState> _normalKey = GlobalKey<FormState>();
  String _name;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _normalKey,
          child: Container(
            margin: EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (val){
                    if(val.isEmpty){
                      return "Name Cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val){
                    _name = val;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your Name Please",
                    prefixIcon: Icon(Icons.verified_user),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: RaisedButton(
                    child: Text("CLICK ON ME"),
                    onPressed: (){
                      if(_normalKey.currentState.validate()){
                        _normalKey.currentState.save();
                        print(_name);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
