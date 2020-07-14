import 'package:flutter/material.dart';
import 'package:learninone/DiscussionForum/CommentsModel.dart';
import 'package:learninone/DiscussionForum/Widgets.dart';
import 'package:learninone/DiscussionForum/classroomModel.dart';
import 'package:learninone/DiscussionForum/postDiscussionsBackend.dart';

class PostDiscussions extends StatefulWidget {
  DiscussionModel post;

  PostDiscussions(this.post);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostDiscussionsState();
  }
}

class PostDiscussionsState extends State<PostDiscussions> {
  String message;
  TextEditingController _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_upload),
          onPressed: () async {
            await showDialog(
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
                                  controller: _messageTextController,
                                ),
                              ),
                            ),
                            RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async => _messageTextController
                                            .text !=
                                        ''
                                    ? await uploadingComment(widget.post.id,
                                            _messageTextController.text)
                                        .then((value) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ));
                                        if (value.statusCode >= 200 &&
                                            value.statusCode < 400) {
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        'Comment submitted!'),
                                                  ));
                                          setState(() {});
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
                    )).whenComplete(() {
              setState(() {});
            });
          }),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Container(
//      color: Colors.red,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.post.title}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('${widget.post.body}'),
                ],
              ),
            ),
            subtitle: Container(
//        color: Colors.blue,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('${widget.post.id}'),
                Container(
                  width: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.message),
                      Text('${widget.post.commentCount}'),
                    ],
                  ),
                ),
                Container(
                  width: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.add_box),
                      Text('${widget.post.score}'),
                    ],
                  ),
                ),
              ],
            )),
          ),
          FutureBuilder<List<CommentsModel>>(
              future: gettingComments(),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              'Comments',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                        ),
                        snapshot.connectionState == ConnectionState.done
                            ? snapshot.data != null
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              child: CommentTile(
                                                  snapshot, index, context));
                                        }),
                                  )
                                : Container(
                                    child: Text('no results found'),
                                  )
                            : Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
