import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/introduction_screen.dart';
import 'dart:async';

Future<void> main() async {
  // Obtain a list of the available cameras on the device.
  //final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  //final firstCamera = cameras.first;

  runApp(
    MaterialApp(theme: ThemeData.light(), home: IntroductionScreen()
        //TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        //camera: firstCamera,

        ),
  );
}
