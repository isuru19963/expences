import 'package:flutter/material.dart';

class dropDown extends StatefulWidget {
  @override
  _dropDownState createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {

  String value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDown"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    value: "1",
                    child: Center(
                      child: Text("ONE"),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "2",
                    child: Center(
                      child: Text("TWO"),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "3",
                    child: Center(
                      child: Text("THREE"),
                    ),
                  ),
                ],
                onChanged: (_value){
                  print(_value.toString());
                  setState(() {
                    value = _value;
                  });
                },
                hint: Text("SELECT ANY NUMBER"),
              ),
            ),
            Text(
              "$value"
            ),
          ],
        ),
      ),
    );
  }
}
