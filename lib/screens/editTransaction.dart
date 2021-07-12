//all main packages start
import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:Expense/screens/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import  'package:image_picker/image_picker.dart';
import  'package:dropdownfield/dropdownfield.dart';
//all main packages ends


class editTransaction extends StatefulWidget {
  final transID;
  editTransaction(this.transID):super();
  @override
  _editTransactionState createState() => _editTransactionState();
}

class _editTransactionState extends State<editTransaction> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController amount = TextEditingController();

  PickedFile _expenceProof;
  final ImagePicker _picker = ImagePicker();
  List dataTrans = List();
  @override


  void initState() {
    super.initState();
    fetchDataListID();
  }
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
        source: source
    );
    setState(() {
      _expenceProof = pickedFile;
    });
  }
  Future<List<dynamic>> fetchDataListID() async {

    var res = await getListById(widget.transID.toString());
    var details=json.decode(res.body)['details'];
    print(details);
    // setState(() {
    //   dataTrans=details;
    //
    // });
    // amount.text='5';
    return json.decode(res.body)['details'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Transaction"),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        // ),
        actions: [
          IconButton(
            icon:Icon(Icons.save),iconSize: 30.0,
            onPressed: (){},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                      size: 30.0,
                      color: Colors.green,
                      // color: kPrimaryColor,
                    ),
                    hintText: "2,000",
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 10.0,),
                DropDownField(
                  controller: selectedPayType,
                  hintText: "Please Select Payment Type",
                  itemsVisibleInDropdown: 5,
                  enabled: true,
                  items: PaymentTypes,
                  onValueChanged: (value){
                    setState(() {
                      selectpaytype = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintMaxLines: 4,
                      prefixIcon: Icon(Icons.menu),
                      hintText: "Water Bill"
                  ),
                ),
                DateTimeField(
                  format: format,
                  onShowPicker: (context, currentValue) {

                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      // color: kPrimaryColor,
                    ),
                    hintText: "2020-10-21",
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  validator: (dateOfBirthValue) {
                    // dob = dateOfBirthValue.toString();
                    return null;
                  },
                ),
                TextFormField(
                  // enabled: false,
                  decoration: InputDecoration(
                      hintMaxLines: 4,
                      prefixIcon: Icon(Icons.menu),
                      hintText: "Cash"
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: _expenceProof == null ? AssetImage("assest/billdummy.jpg") : FileImage(File(_expenceProof.path)),
                  ),
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
                          Text("Gallery", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String selectpaytype;
final selectedPayType= TextEditingController();
List<String> PaymentTypes = [
  "Test - a",
  "Test - a",
  "Test - a",
  "Test - a",
  "Test - a",
  "Test - a",
  "Test - a",

];
