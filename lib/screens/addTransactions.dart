//all material packages start
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Expense/screens/api.dart';
import 'dart:io' as Io;
import 'api.dart';
import 'package:http/http.dart' as http;
import'mainDashboard.dart';
import 'package:Expense/models/note.dart';
import 'package:Expense/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class addTransaction extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  addTransaction(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return addTransactionState(this.note, this.appBarTitle);
  }
}

class addTransactionState extends State<addTransaction> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController amount = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController user_card_no = TextEditingController();
  TextEditingController client = TextEditingController();
  TextEditingController employee = TextEditingController();
  TextEditingController traveling = TextEditingController();
  TextEditingController entertainment = TextEditingController();
  TextEditingController noneEntertainment = TextEditingController();
  TextEditingController gstController = TextEditingController();


  addTransactionState(this.note, this.appBarTitle);


  PickedFile _expenceproof;
  final ImagePicker _picker = ImagePicker();

  final format = DateFormat("yyyy-MM-dd");
  List stateList = [];
  List cardList = [];
  List departmentList = [];
  var payment_type = "COMPUTER";
  var department;
  var allCardList = "...............1234";
  var userDividends = ['Employee', 'Client', 'Employee & Client', 'Travelling'];
  var selectedByUser = "Employee";
  double gst;

  bool currencyStatus = false;

  Future getAllTypes() async {
    var response = await http.get(Uri.parse("https://ccemapp.edlyn.com.au/api/Settings/GetTransTypes"),
        headers: {"Accept": "Applications/json"});

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      setState(() {
        stateList = jsonData['transTypes'];
      });
    }
  }

  Future getAllDepartment() async {
    var response = await http.get(Uri.parse("https://ccemapp.edlyn.com.au/api/Settings/GetDepartments"),
        headers: {"Accept": "Applications/json"});

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      setState(() {
        departmentList = jsonData['Departments'];
      });
    }
  }

  Future getAllCards() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var unique_id = localStorage.getString('user');
    var response = await http.post(Uri.parse('https://ccemapp.edlyn.com.au/api/Settings/GetCards'),
        body: {
          "unique_id": unique_id
        },
        headers: {"Accept": "Applications/json"});

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      setState(() {
        cardList = jsonData['creditCards'];
      });
    }
  }

  shareDate() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var unique_id = localStorage.getString('user');
    var u_card_no = localStorage.getString('card_no');
    var u_department = localStorage.getString('department');
    setState(() {
      department = u_department;
    });
  }

  @override

  void initState() {
    super.initState();
    getAllTypes();
    shareDate();
    getAllCards();
    getAllDepartment();
    gst;
    note.empClient = "E";
    print("IMG is $_expenceproof");

    if(this.note.transType.isEmpty || this.note.transType == null){
    } else {
      payment_type = this.note.transType.toString();
    }

    if(this.note.cardNo.isEmpty || this.note.cardNo == null){

    } else {
      allCardList = this.note.cardNo;
    }

    if(this.note.payDate.isEmpty || this.note.payDate == null){
    } else {
      // date.text = this.note.payDate;
      print("came here 1st");
      print(this.note.payDate.toString());
      this.note.payDate = date.text;
      print("came here 2nd");
    }

  }

  Widget build(BuildContext context) {

    amount.text = note.amount;
    date.text = note.payDate;
    notes.text = note.note;
    user_card_no.text = note.cardNo.toString();
    client.text = note.client;
    employee.text = note.employees;
    traveling.text = note.traveling;
    entertainment.text = note.entertainment;
    noneEntertainment.text = note.noneEntertainment;
    gstController.text = note.gst;
    //note.transType = payment_type;

    return WillPopScope(
      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              moveToLastScreen();
              // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //   return mainDashboard();
              // }));
            },
          ),
          actions: [
            IconButton(
              // icon: Icon(Icons.save_outlined),
                icon: Text("Save"),
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    // postTransaction();
                    _save();
                  }
                })
          ],
        ),
        body: SingleChildScrollView(
          // print(this.note);
          child: Form(
            key:_formKey,
            child: Container(
              margin: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    controller: amount,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.monetization_on_outlined,
                        size: 30.0,
                        color: Colors.green,
                      ),
                      hintText: "Amount",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    onFieldSubmitted: (val){
                      setState(() {
                        gst = (double.parse(val)) / 11;
                        note.gst = gst.toStringAsFixed(2,);
                        print(note.gst);
                      });
                    },
                    onChanged: (value){
                      setState(() {
                        gst = (double.parse(value)) / 11;
                        print(gst);
                      });

                      updateAmount();
                      updateDate(format.format(DateTime.now()));
                      // print('$gst $value');
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Amount';
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("GST : "),
                          SizedBox(
                              width: 70,
                              child: TextField(
                                controller: gstController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: gst == null ? "0": gst.toStringAsFixed(2,)
                                ),
                                onChanged: (value){
                                  note.gst = value;
                                  print(note.gst);
                                },
                              )
                          ),
                          // gst == null ? Text("0") : Text(gst.toStringAsFixed(3,)),
                        ],
                      ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text("Foreign Currency", style: TextStyle(fontSize: 16.0),),
                         Checkbox(
                           value: currencyStatus,
                           onChanged: (value){
                             currencyStatus = !currencyStatus;
                             setState(() {});
                           },
                         ),
                       ],
                     )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.verified,color: Colors.red,size: 30.0,),
                          Expanded(
                            child: DropdownButtonFormField(
                              items: stateList.map((pType){
                                return DropdownMenuItem(
                                    value: pType['trans_type'],
                                    child: Text(pType['trans_type'])
                                );
                              }).toList(),
                              value: payment_type,
                              validator: (value){
                                if(value == null){
                                  return "Please select payment type";
                                }
                              },
                              // value: getPayTypeAsString(note.transType.toString()),
                              onChanged: (value){
                                setState(() {
                                  print(value);
                                  payment_type = value;
                                  // updatePayType(value);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.videogame_asset,color: Colors.green,size: 30.0,),
                          Expanded(
                            child: DropdownButtonFormField(
                              items: departmentList.map((dType){
                                return DropdownMenuItem(
                                    value: dType['department'],
                                    child: Text(dType['department'])
                                );
                              }).toList(),
                              value: department,
                              validator: (value){
                                if(value == null){
                                  return "Please select payment type";
                                }
                              },
                              // value: getPayTypeAsString(note.transType.toString()),
                              onChanged: (value){
                                setState(() {
                                  print(value);
                                  department = value;
                                  updateDepartment(value);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  DateTimeField(
                    format: format,
                    initialValue: DateTime.now(),
                    onChanged: (value){
                      //print(value);
                      updateDate(value.toString());
                    },

                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.date_range_sharp, color: Colors.red,
                        // color: kPrimaryColor,
                    ),
                    // hintText: "Select Date",
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                    ),
                    validator: (value) {
                      if(value == null){
                        return 'Please select date';
                      }
                      // date = value.toString();
                      return null;
                    },
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.credit_card,color: Colors.green,size: 30.0,),
                      // SizedBox(
                      //   width: 20.0,
                      // ),
                      Expanded(
                        child: DropdownButtonFormField(
                          hint: Text("Select Card"),
                          items: cardList.map((pType){
                            return DropdownMenuItem(
                                value: pType['card_no'],
                                child: Text(pType['card_no'])
                            );
                          }).toList(),
                          validator: (value){
                            if(value == null){
                              return "Please Select Card";
                            }
                          },
                          value: allCardList,
                          // value: getPayTypeAsString(note.transType.toString()),
                          onChanged: (value){
                            setState(() {
                              allCardList = value;
                              // updatePayType(value);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_outline,color: Colors.red,size: 30.0,),
                      Expanded(
                        child: DropdownButtonFormField(
                          hint: Text("Select Payment Type"),
                          items: userDividends.map((String dropDownItems){
                            return DropdownMenuItem(
                                value: dropDownItems,
                                child: Text(dropDownItems)
                            );
                          }).toList(),
                          value: selectedByUser,
                          validator: (value){
                            if(value == null){
                              return "Please select payment type";
                            }
                          },
                          // value: getPayTypeAsString(note.transType.toString()),
                          onChanged: (value){
                            setState(() {
                              selectedByUser = value;
                              updateEmpClient(value);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    child:selectedByUser == "Employee & Client" ? OtherWidget() :Text(""),
                  ),
                  Container(
                    child:selectedByUser == "Travelling" ? travelingWidget() :Text(""),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintMaxLines: 4,
                        prefixIcon: Icon(Icons.menu, color: Colors.green,size: 30.0,),
                        hintText: "Write Note"
                    ),
                    controller: notes,
                    onChanged: (value){
                      updateNote();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Note';
                      }
                    },
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          // color: Colors.red,
                          child: FlatButton.icon(
                            color: Colors.grey,
                            onPressed: (){
                              takePhoto(ImageSource.camera);
                            },
                            icon: Icon(Icons.camera_alt_outlined),
                            label:
                            Text("Camera", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          // color: Colors.red,
                          child: FlatButton.icon(
                            color: Colors.grey,
                            onPressed: (){
                              takePhoto(ImageSource.gallery);
                            },
                            icon: Icon(Icons.photo),
                            label:
                            Text("Gallery"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 100.0,
                          backgroundImage: _expenceproof == null ? AssetImage("assest/billdummy.jpg") : FileImage(File(_expenceproof.path == null ? "assest/billdummy.jpg":_expenceproof.path)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
        source: source
    );
    setState(() {
      pickedFile != null ? _expenceproof = pickedFile : _expenceproof = "assest/billdummy.jpg" as PickedFile;
      postTransaction();
    });
  }

  void postTransaction() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var user = localStorage.getString('email');
    // var unique_id = localStorage.getString('user');
    // var u_card_no = localStorage.getString('card_no');

    // print(unique_id);

    if(_expenceproof == null){
      _showAlertDialog(context, "No such a image added");
      return;
    } else {
      String image = _expenceproof.path;
      final bytes = await Io.File(_expenceproof.path).readAsBytes();
      note.payProof = bytes.toString();
      print(bytes);
      //print(image);
      // String img64 = base64Encode(bytes);
    }

    // var data = [
    //   {
    //     "originator":"1",
    //     "originator_unique": unique_id,
    //     "email": user,
    //     "trans_type": payment_type.toString(),
    //     "amount":amount,
    //     "pay_type": "",
    //     "card_no":u_card_no,
    //     "pay_date": date,
    //     "note":note,
    //     "pay_proof":"",
    //     "filepath":"",
    //     "status": 'N'
    //   }
    // ];

    // var rsp = await PostTransactionApi(data);
    // _showAlertDialog(context, "OK");
    // print(context);
  }

  void _showAlertDialog(context, String mess){
    AlertDialog alertDialog = AlertDialog(
      title: Text("Expense Successfully added ", style: TextStyle(fontSize: 12.2),),
      content: Text(mess),
      actions: [
        RaisedButton(
          color: Colors.lightBlue,
          child: Text("CLEAR DATA"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }

  void updateAmount(){
    note.amount = amount.text;
  }

  void updateNote(){
    note.note = notes.text;
  }

  void updateDate(String enterDate){
    //note.payDate = enterDate;
    var dT = format.format(DateTime.tryParse(enterDate));
    if(note.payDate.isEmpty || note.payDate==null){
      note.payDate = format.format(DateTime.tryParse(enterDate));
    } else {
      note.payDate = enterDate;
    }
    print(enterDate);
  }

  void updatePayType(String value){
    note.transType = value;
  }

  void updateEmpClient(value){
    if(value == "Employee"){
      note.empClient = "E";
    }  else if(value == "Client"){
      note.empClient = "C";
    } else if(value == "Employee & Client"){
      note.empClient = "EC";
    } else if(value == "Travelling"){
      note.empClient = "T";
    }
    print(note.empClient);
  }

  void updateClient(){
    note.clients = client.text;
  }

  void updateEmployee(){
    note.employees = employee.text;
  }

  void updateDepartment(String value){
    note.department = value;
  }

  void updateTravelling(){
    note.traveling = traveling.text;
  }

  void updateEntertainment(){
    note.entertainment = entertainment.text;
  }

  void updateNoneEntertainment(){
    note.noneEntertainment = noneEntertainment.text;
  }

  String getPayTypeAsString(String value){
    String payType;
    payType = stateList[value as int];
    return payType;
  }

  Widget travelingWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: traveling,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.directions_walk,
                size: 20.0,
                color: Colors.green,
              ),
              hintText: "Travelling",
              hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: (value){
              updateTravelling();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter value';
              }
            },
          ),
          // SizedBox(height: 12.0,),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: entertainment,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.play_arrow,
                size: 20.0,
                color: Colors.green,
              ),
              hintText: "Entertainment",
              hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: (value){
              updateEntertainment();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter value';
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: noneEntertainment,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.play_disabled,
                size: 20.0,
                color: Colors.green,
              ),
              hintText: "Non-Entertainment",
              hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: (value){
              updateNoneEntertainment();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter value';
              }
            },
          ),
        ],
      ),
    );
  }


  Widget OtherWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            // keyboardType: TextInputType.number,
            controller: employee,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                size: 20.0,
                color: Colors.green,
              ),
              hintText: "Employee",
              hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: (value){
              updateEmployee();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Employee';
              }
            },
          ),
          // SizedBox(height: 12.0,),
          TextFormField(
            // keyboardType: TextInputType.number,
            controller: client,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                size: 20.0,
                color: Colors.green,
              ),
              hintText: "Client",
              hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: (value){
              updateClient();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Client';
              }
            },
          ),
        ],
      ),
    );
  }

  void _save() async{

    note.transType = payment_type;
    note.cardNo = allCardList;

    moveToLastScreen();
    // note.payDate = DateFormat.yMd().format(DateTime.now());
    // note.payDate = DateFormat().add_yMd().format(DateTime.now());
    //DateFormat().add_yMd().format(DateTime.now())
    // note.payDate = date.text;
    print(note.payDate.toString());
    print(date.text);
    int result;
    if(note.id != null){
      result = await helper.updateTrtansaction(note);
    } else {
      result = await helper.insertTransaction(note);
      if(result == null){
        print('Null goes here');
      } else {
        print('Not Null');
      }
    }

    if(result != 0){
      _showAlert('Status', 'Expense saved successfully');
    } else {
      _showAlert('Status', 'Problem saving expense..! Contact Administrator');
    }
  }

  _showAlert(String status, String messege){
    AlertDialog alertDialog = AlertDialog(
      title: Text(status),
      content: Text(messege),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}