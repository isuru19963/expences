import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class camerOnUp extends StatefulWidget {
  @override
  _camerOnUpState createState() => _camerOnUpState();
}

class _camerOnUpState extends State<camerOnUp> {

  File imageFile;

  _OpenGallary(BuildContext context) async{
    var pickture = await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickture as File;
    this.setState(() {
      return imageFile;
    });
    Navigator.of(context).pop(camerOnUp());
  }

  _Opencamera(BuildContext context) async{
    // var pick = await ImagePicker().getImage(source: ImageSource.camera);
    // this.setState(() {
    //   imageFile = pick as File;
    // });
    // Navigator.of(context).pop();
    var pick = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imageFile = pick as File;
      print("Done with DULANJAN : $imageFile");
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        title: Text("Select One"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _OpenGallary(context);
                },
              ),
              Padding(padding: EdgeInsets.all(20.0),),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _Opencamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Text("Please Select the Image");
    } else {
      return Image.file(imageFile, width: 400, height: 500,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST"),
      ),
      body:Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _decideImageView(),
              RaisedButton(
                onPressed: (){
                  _showChoiceDialog(context);
                },
                child: Text("Select Image"),
              ),
            ],
          ),
        ),
      )
    );
  }
}
