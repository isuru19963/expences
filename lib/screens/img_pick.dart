// import 'dart:html';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class cam_detect extends StatefulWidget {
  @override
  _cam_detectState createState() => _cam_detectState();
}

class _cam_detectState extends State<cam_detect> {

  PickedFile imageURI;
  final ImagePicker _picker = ImagePicker();

  Future getImageFromCameraGallery(bool isCamera) async {
    var image = await _picker.getImage(source: (isCamera == true) ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: imageURI == null ? Text("There is no image Select") : Image.file(File(imageURI.path)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              getImageFromCameraGallery(true);
            },
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(width: 15,),
          FloatingActionButton(
            onPressed: (){
              getImageFromCameraGallery(false);
            },
            child: Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}
