import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'home_screen.dart';
import 'gallery_screen.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  var firstCamera;
  @override
  initState() {
    super.initState();
    getready();
  }

  Future<void> getready() async {
    final cameras = await availableCameras();
    print('Initialized');

    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppBar(
                leading: Icon(Icons.account_box),
                title: Text(
                  'D_R Classifier',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red //Color(0xff99DFB2),
                ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 49.0, right: 49.0),
                      child: RaisedButton(
                        elevation: 8,
                        highlightElevation: 8,
                        hoverElevation: 20,
                        highlightColor: Colors.white30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                    source: ImageSource.gallery,
                                    appBarText:
                                        Text('Select A Sample Of Left-Eye'),
                                    icon: Icon(Icons.image),
                                    typeOfCapture: "imgL",
                                    nameOfCapture: "imgL_Name")),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Select A Sample Of Left-Eye',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                            )
                          ],
                        ),
                        color: Colors.redAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 49.0, right: 49.0),
                      child: RaisedButton(
                        elevation: 8,
                        highlightElevation: 8,
                        highlightColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                    source: ImageSource.gallery,
                                    appBarText:
                                        Text('Select A Sample Of Right-Eye'),
                                    icon: Icon(Icons.image),
                                    typeOfCapture: "imgR",
                                    nameOfCapture: "imgR_Name")),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Select A Sample Of Right-Eye',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.redAccent,
                            )
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
