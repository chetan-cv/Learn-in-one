import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learninone/Widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class EcontentPage extends StatefulWidget {
  @override
  _EcontentPageState createState() => _EcontentPageState();
}

class _EcontentPageState extends State<EcontentPage> {
  File sampleFile;
  bool fileUploaded = false;
  Future getFile() async {
    var tempFile = await FilePicker.getFile();
    setState(() {
      sampleFile = tempFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => getFile(),
          child: Icon(Icons.cloud_upload),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Text(
                  'E-Content',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.blue,
                    fontFamily: 'Yellowtail',
                  ),
                ),
              ),
            ),
          ),
          Center(
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: fileUploaded == false
                      ? sampleFile == null
                          ? Text("Please upload a image")
                          : choiceWidget()
                      : Text(
                          "File ${path.basenameWithoutExtension(sampleFile.path).toString()} uploaded successfully")))
        ]),
      ),
    );
  }

  Widget choiceWidget() {
    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Text(
            path.basenameWithoutExtension(sampleFile.path).toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () async {
                final StorageReference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child(path
                        .basenameWithoutExtension(sampleFile.path)
                        .toString());
                final StorageUploadTask task =
                    firebaseStorageRef.putFile(sampleFile);
                setState(() {
                  fileUploaded = true;
                });
              },
              child: Center(
                  child: Icon(
                Icons.cloud_upload,
                size: 40,
              )),
              color: Colors.green,
            ),
            SizedBox(width: 40),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.red)),
              onPressed: () {
                setState(() {
                  sampleFile = null;
                });
              },
              child: Center(
                  child: Icon(
                Icons.delete,
                size: 40,
              )),
              color: Colors.red,
              splashColor: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
