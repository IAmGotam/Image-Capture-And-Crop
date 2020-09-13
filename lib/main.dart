import 'package:flutter/material.dart';
import 'package:image_capture/Camera_Capture_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Camera_Capture_Screen(),
    );
  }
}
