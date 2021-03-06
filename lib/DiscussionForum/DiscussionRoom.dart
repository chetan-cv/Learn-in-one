import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/adsense/v1_4.dart';
import 'package:learninone/DiscussionForum/Widgets.dart';
import 'classroomModel.dart';
import 'discussionForumBackend.dart';

class DiscussionRoom extends StatefulWidget {
  String tag;

  DiscussionRoom({this.tag});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DiscussionRoomState();
  }
}

class DiscussionRoomState extends State<DiscussionRoom> {
  TextEditingController _question;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = TextEditingController(text: '');
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cloud_upload),
          onPressed: () async {
            return await showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 300.0,
                        width: 200.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Enter your Question',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(
                                        width: 1.0, color: Colors.blue)),
                                child: TextFormField(
                                  key: _formKey,
                                  controller: _question,
                                ),
                              ),
                            ),
                            RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async => _question.text != ''
                                    ? await postingQuestion(
                                            widget.tag, _question.text)
                                        .then((value) async {
                                        if (value.statusCode >= 200 &&
                                            value.statusCode < 400) {
                                          await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        'Question submitted!'),
                                                  )).whenComplete(() => setState((){}));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        'Something went wrong'),
                                                  ));
                                        }
                                      })
                                    : showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title:
                                                  Text('Please enter question'),
                                            )))
                          ],
                        ),
                      ),
                    ));
          }
//            postingQuestion(tag),
          ),
      body: FutureBuilder<List<DiscussionModel>>(
          future: gettingDiscussion(widget.tag),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null
                ? Container(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => Card(
                            child: QuestionTile(snapshot, index, context))),
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }),
    );
  }
}
