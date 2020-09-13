import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Camera_Capture_Screen extends StatefulWidget {
  @override
  _Camera_Capture_ScreenState createState() => _Camera_Capture_ScreenState();
}

class _Camera_Capture_ScreenState extends State<Camera_Capture_Screen> {
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[600],
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Capture Image and Crop',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[600],
        ),
        body: mainLayout(),
      )),
    );
  }

  Widget mainLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imageBox(),
          SizedBox(
            height: 20,
          ),
          cameraButton(),
        ],
      ),
    );
  }

  Widget imageBox() {
    if (_imageFile != null) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.file(
          _imageFile,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        height: 250,
        width: 250,
        color: Colors.black.withOpacity(0.2),
        alignment: Alignment.center,
        child: Text(
          'Capture Image Here',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      );
    }
  }

  Widget cameraButton() {
    return RaisedButton(
      color: Colors.green[600],
      textColor: Colors.white,
      onPressed: () {
        getImageFile(ImageSource.camera);
      },
      child: Text('Camera'),
    );
  }

  getImageFile(ImageSource imageSource) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: imageSource);

    File cropImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
      androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.green[600],
          backgroundColor: Colors.white,
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.green[600],
          toolbarWidgetColor: Colors.white),
    );

    setState(() {
      _imageFile = cropImage;
    });
  }
}
