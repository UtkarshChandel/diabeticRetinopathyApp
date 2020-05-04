import 'dart:convert';
import 'dart:io';

import 'package:diabeticretinopathy/src/screens/akashScreen.dart';
import 'package:diabeticretinopathy/src/screens/squirrelButton.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  final ImageSource source;
  final Widget appBarText;
  final Widget icon;
  final String typeOfCapture;
  final String nameOfCapture;

  const MyHomePage(
      {Key key,
      @required this.source,
      @required this.appBarText,
      @required this.icon,
      @required this.typeOfCapture,
      @required this.nameOfCapture})
      : super(key: key);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    //fetch();
  }

  final databaseReference = FirebaseDatabase.instance.reference();

  File _image;

  Future<void> createRecord(base64Img, name) async {
    await databaseReference
        .child("users")
        .update({widget.typeOfCapture: base64Img, widget.nameOfCapture: name});

    await databaseReference.child("users").update({
      "processedImgR": "",
      "processedImgL": "",
      "valueImageProcessedL": "",
      "valueImageProcessedR": ""
    });
  }

  fetch() {
    print('Hey I am Fetch');
    databaseReference
        .child("users")
        .child("processedImgL")
        .onValue
        .listen((event) => (print(event.snapshot.value)));
    databaseReference
        .child("users")
        .child("processedImgR")
        .onValue
        .listen((event) => (print(event.snapshot.value)));
    // Query _todo = databaseReference.child("users").child("description");

    // _todo.onChildAdded.listen((data) => (print(data)));
    // _todo.onChildChanged.listen((data) => (print(data)));
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: widget.source);
    var name = path.basename(image.path).split("scaled_")[1];
    var base64Img = base64Encode(File(image.path).readAsBytesSync());
    await createRecord(base64Img, name);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: widget.appBarText,
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(34.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(_image),
                    ),
                  ),
                  SquirrelButton(
                    buttonText: "Process",
                    onTap: () => (Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AkashScreen()),
                    )),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: widget.icon,
      ),
    );
  }
}
