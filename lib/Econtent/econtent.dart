import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learninone/Widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class EcontentPage extends StatefulWidget {
  @override
  _EcontentPageState createState() => _EcontentPageState();
}

class _EcontentPageState extends State<EcontentPage> {
  File sampleFile, inSampleFile;
  bool fileUploaded = false;
  String fileType = "None";

  Future getFile() async {
    /*
    * Function to get the file from the file system using FilePicker
     */
    var tempFile = await FilePicker.getFile();
    setState(() {
      sampleFile = tempFile;
    });
  }

  Future<FirebaseApp> connectFirebase() async {
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'db',
      options: FirebaseOptions(
        googleAppID: '1:144653325752:android:0f7cc380deb5f996b42b4d',
        apiKey: 'AIzaSyAbw8KaqH5JuY43qOABPJ1xtzsIA1dIn-8',
        databaseURL: 'https://learn-in-one-1594051122808.firebaseio.com/',
      ),
    );
    return app;
  }

  var firebaseRef =
      FirebaseDatabase().reference().child("learn-in-one-1594051122808");
  List<String> folderNames = [
    "images",
    "pdfs",
    "docs",
    "sheets",
    "presentations",
    "others"
  ];
  List<Icon> icons = [
    Icon(Icons.image),
    Icon(Icons.picture_as_pdf),
    Icon(OpenIconicIcons.document),
    Icon(OpenIconicIcons.spreadsheet),
    Icon(Icons.present_to_all),
    Icon(Icons.add_box),
  ];

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> folders) {
    List<DropdownMenuItem<String>> items = List();
    for (String folder in folders) {
      items.add(
        DropdownMenuItem(
          value: folder,
          child: Text(folder),
        ),
      );
    }
    return items;
  }

  var app;

  List<DropdownMenuItem<String>> dropDownMenuItems;
  @override
  void initState() {
    super.initState();
    dropDownMenuItems = buildDropdownMenuItems(folderNames);
    fileType = dropDownMenuItems[0].value;
    app = connectFirebase();
    print(dropDownMenuItems);
    print(app);
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
          Divider(),
          retWidgetWithCondition()
        ]),
      ),
    );
  }

  onChangedDropDownItem(String selectedFileType) {
    setState(() {
      fileType = selectedFileType;
    });
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
            Text("Select file Type:"),
            SizedBox(width: 10),
            DropdownButton(
                items: dropDownMenuItems,
                value: fileType,
                onChanged: onChangedDropDownItem)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () async {
                final StorageReference storageRef = FirebaseStorage.instance
                    .ref()
                    .child(
                        '${fileType}/${path.basename(sampleFile.path).toString()}');
                final StorageUploadTask task = storageRef.putFile(sampleFile);
                String filename= path.basename(sampleFile.path).toString();
                await task.onComplete;
                print('File Uploaded');
                storageRef.getDownloadURL().then((fileURL) {
                  // setState(() {
                  //   _uploadedFileURL = fileURL;
                  // });
                  print(fileURL);
                  print(filename);
                  // firebaseRef.push().set({
                  //   "file_name": path.basenameWithoutExtension(sampleFile.path).toString(),
                  //   "file_url": fileURL.toString()
                  // });
                });
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

  Widget retWidgetWithCondition() {
    print(sampleFile);
    print(fileUploaded);
    if (sampleFile == null && fileUploaded == false) {
      return Expanded(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: folderNames.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      leading: icons[index],
                      title: Text(folderNames[index]),
                    );
                  }),
            ),
          ],
        ),
      );
    } else if (sampleFile != null && fileUploaded == false) {
      return choiceWidget();
    } else if (sampleFile != null && fileUploaded == true) {
      setState(() {
        inSampleFile = sampleFile;
        sampleFile = null;
        fileUploaded = false;
      });

// Find the Scaffold in the widget tree and use it to show a SnackBar.

      return Expanded(
        flex: 3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: folderNames.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: icons[index],
                          title: Text(folderNames[index]),
                        ),
                        Divider()
                      ],
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Text(
                  "File ${path.basenameWithoutExtension(inSampleFile.path).toString()}uploaded successfully"),
            )
          ],
        ),
      );
    }
  }
}
