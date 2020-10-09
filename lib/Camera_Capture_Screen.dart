import 'dart:io';

import 'package:flutter/material.dart';
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
        showSelectImageBottomSheet(context);
      },
      child: Text('Take Image'),
    );
  }

  void showSelectImageBottomSheet(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      builder: (BuildContext bc) {
        return Container(
          height: height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  Navigator.pop(context, true);
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                      maxHeight: 2080,
                      maxWidth: 2080);

                  File cropImage = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    maxHeight: 2080,
                    maxWidth: 2080,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                  );
//

                  setState(() {
                    _imageFile = cropImage;
                  });
                },
                icon: Icon(
                  Icons.camera_alt,
                ),
                label: Text(
                  'Camera',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              FlatButton.icon(
                onPressed: () async {
                  Navigator.pop(context, true);
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                      maxHeight: 2080,
                      maxWidth: 2080);

                  File cropImage = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    maxHeight: 2080,
                    maxWidth: 2080,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                  );
//

                  setState(() {
                    _imageFile = cropImage;
                  });
                },
                icon: Icon(
                  Icons.photo_library,
                ),
                label: Text(
                  'Gallery',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
