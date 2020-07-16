import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Page2 extends StatefulWidget {
  final String folderName;
  Page2({@required this.folderName});
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  var fileTypeToFirebase = {
    "images": FirebaseDatabase().reference().child("images"),
    "docs": FirebaseDatabase().reference().child("docs"),
    "pdfs": FirebaseDatabase().reference().child("pdfs"),
    "sheets": FirebaseDatabase().reference().child("sheets"),
    "presentations": FirebaseDatabase().reference().child("presentations"),
    "others": FirebaseDatabase().reference().child("others")
  };

  var progress = "";
  bool downloading = false;

  Future<void> _download(String url,String fileName) async {
    Dio dio = Dio();

    var dirToSave = await getApplicationDocumentsDirectory();

    await dio.download(url, "${dirToSave.path}/${fileName}",
        onReceiveProgress: (rec, total) {
      setState(() {
        downloading = true;
        progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });

    try {} catch (e) {
      throw e;
    }
    setState(() {
      downloading = false;
      progress = "Complete";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
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
      ),
      Divider(),
      downloading ? CircularProgressIndicator() : SizedBox(),
            SizedBox(height: 10),
            downloading ? Text(progress) :StreamBuilder(
        stream: fileTypeToFirebase[widget.folderName].onValue,
        builder: (context, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            List item = [];

            data.forEach((key, value) {
              item.add(data[key]);
            });

            return Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(item[index]['file_name']),
                        trailing: InkWell(onTap: (){
                          _download(item[index]['file_url'], item[index]['file_name']);
                        },child: Icon(Icons.cloud_download,size:30),),
                        // onTap: () =>
                        //     updateTimeStamp(item[index]['key']),
                      ),
                      Divider()
                    ],
                  );
                },
              ),
            );
          } else
            return Text("No data");
        },
      )
    ]));
  }
}
