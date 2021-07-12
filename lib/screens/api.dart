import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

//var dataCenterMainURL = "https://expenseapp.msalesapp.com";
var dataCenterMainURL = "https://ccemapp.edlyn.com.au";
//var cliendMainDataCenter = "https://ccemapp.edlyn.com.au";

Future loginUser(String email, password) async {
  var url = Uri.parse(dataCenterMainURL+"/api/User/Login");

  final response = await http.post(url,
      headers: {"Accept":"Applications/json"},
      body:{'email': email, 'password' :password}
      );
  var convertedJaasonData = jsonDecode(response.body);
  // print(convertedJaasonData);
  return convertedJaasonData;
}

Future registrationUser(String email, password) async{
  var url = Uri.parse(dataCenterMainURL+"/api/User/Register");
  final response = await http.post(url,
  headers: {"Accept": "Applications/json"},
    body: {'email':email, 'password':password}
  );
  var convertedJsonData = jsonDecode(response.body);
  return convertedJsonData;
}

 Future PostTransactionApi(dataPost) async{
  print(dataPost);
  var url = Uri.parse(dataCenterMainURL+"/api/Statement/Save");
  final response = await http.post(url,
      headers: {"Accept": "Applications/json","Content-type" : "application/json"},
      body: jsonEncode(dataPost),
  );
  var convertedJsonData = jsonDecode(response.body);
  // print( convertedJsonData);
  return convertedJsonData;
}

Future getList(getData) async{
  var url = Uri.parse(dataCenterMainURL+"/api/Statement/GetList");
  return await http.post(url,
    headers: {"Accept": "Applications/json","Content-type" : "application/json"},
    body: jsonEncode(getData),
  );
  // var convertedJsonData = jsonDecode(response.body);
  // return convertedJsonData;
}
Future getListById(id) async{
  var url = Uri.parse(dataCenterMainURL+"/api/Statement/Read/"+id);
  return await http.get(url,
    headers: {"Accept": "Applications/json","Content-type" : "application/json"},
  );
  // var convertedJsonData = jsonDecode(response.body);
  // return convertedJsonData;
}

Future tranUpdate(data) async{
  var url = Uri.parse(dataCenterMainURL+"/api/Statement/Update");
  return await http.post(url,
    headers: {"Accept": "Applications/json","Content-type" : "application/json"},
    body: jsonEncode(data),
  );
  // var convertedJsonData = jsonDecode(response.body);
  // return convertedJsonData;
}

Future GetTransTypes() async {
  var url = Uri.parse(dataCenterMainURL+"/api/Settings/GetTransTypes");
  var res = await http.get(url,
    headers: {"Accept": "Applications/json","Content-type" : "application/json"},);
  var responseD = jsonDecode(res.body);
  // print(responseD);
  return responseD;
}