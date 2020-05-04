import 'dart:convert';
import 'dart:typed_data';

import 'package:diabeticretinopathy/src/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:diabeticretinopathy/src/screens/squirrelButton.widget.dart';
import 'package:firebase_database/firebase_database.dart';

class AkashScreen extends StatefulWidget {
  @override
  _AkashScreenState createState() => _AkashScreenState();
}

class _AkashScreenState extends State<AkashScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  Uint8List imageL;
  Uint8List imageR;

  String valueL;
  String valueR;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  fetch() async {
    print('Hey I am <Watcher>');
    databaseReference
        .child("users")
        .child("processedImgL")
        .onValue
        .listen((event) {
      var image1 = event.snapshot.value;
      print(image1);
      if (image1 != "") {
        Uint8List bytes = base64Decode(image1.toString());
        setState(() {
          imageL = bytes;
          loading = false;
        });
      }
    });
    databaseReference
        .child("users")
        .child("processedImgR")
        .onValue
        .listen((event) {
      var image2 = event.snapshot.value;
      if (image2 != "") {
        Uint8List bytes = base64Decode(image2.toString());
        setState(() {
          imageR = bytes;
          loading = false;
        });
      }
    });
    databaseReference
        .child("users")
        .child("valueImageProcessedL")
        .onValue
        .listen((event) {
      var valueProcesedL = event.snapshot.value;

      setState(() {
        valueL = valueProcesedL;
      });
    });

    databaseReference
        .child("users")
        .child("valueImageProcessedR")
        .onValue
        .listen((event) {
      var valueProcesedR = event.snapshot.value;
      setState(() {
        valueR = valueProcesedR;
      });
    });
    // Query _todo = databaseReference.child("users").child("description");

    // _todo.onChildAdded.listen((data) => (print(data)));
    // _todo.onChildChanged.listen((data) => (print(data)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.image), onPressed: null),
            //centerTitle: true,
            title: Text(
              "Image Results",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            // shape: RoundedRectangleBorder(
            //     borderRadius:
            //         BorderRadius.vertical(bottom: Radius.circular(30))),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                renderImagesAndValues(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                SquirrelButton(
                  buttonText: 'Upload Another Image',
                  onTap: () => (Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntroductionScreen(),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderImagesAndValues() {
    if (loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
              )
            ],
          ),
        ),
      );
    } else {
      return Row(children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              imageL == null ? Text("null") : Image.memory(imageL),
              valueL == null ? Text("null") : Text("Left " + valueL)
            ],
          ),
        )),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              imageR == null ? Text("null") : Image.memory(imageR),
              valueR == null ? Text("null") : Text("Right " + valueR)
            ],
          ),
        ))
      ]);
    }
  }
}
