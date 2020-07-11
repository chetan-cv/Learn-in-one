import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learninone/DiscussionForum/Widgets.dart';
import 'package:learninone/DiscussionForum/classroomModel.dart';
import 'package:learninone/DiscussionForum/discussionForumBackend.dart';
import 'DiscussionRoom.dart';

class DiscussionForum extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DiscussionForumState();
  }
}

class DiscussionForumState extends State<DiscussionForum> {
  TextEditingController _searchedString = TextEditingController(text: '');
  String searchedString = '';
  List<String> tags = [
    "Physics",
    "Chemistry",
    "Maths",
    "Civics",
    "Geography",
    "History",
    "Computer\nScience",
    "Home\nScience",
    "Biology",
    "Physics",
    "Chemistry",
    "Mathematics",
    "English",
    "Economics",
    "Political\nScience",
    "Hindi"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  'Discussion Forum',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
//            Container(
//              height: 30.0,
//            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
//                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: 50.0,
                              child: TextFormField(
                                controller: _searchedString,
                                onEditingComplete: () =>
                                    searchedString = _searchedString.text,
                                onChanged: (value) =>
                                    searchedString = _searchedString.text,
                              ))),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            searchedString = _searchedString.text;
                          });
                        },
                        color: Colors.blue,
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DiscussionModel>>(
                  future: gettingSearchedDiscussion(searchedString),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
//                      height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Choose topic',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Container(
                              height: 30.0,
                            ),
                            searchedString == ''
                                ? Expanded(
                                    child: Container(
                                      child: GridView.builder(
                                        itemCount: tags.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 2.0),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DiscussionRoom(
                                                            tag: tags[index]))),
                                            child: GridTile(
                                                child: Card(
                                                    elevation: 2.0,
                                                    child: Center(
                                                        child: Text(
                                                      tags[index],
                                                      textAlign:
                                                          TextAlign.center,
                                                    )))),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : snapshot.connectionState ==
                                        ConnectionState.done
                                    ? snapshot.data != null
                                        ? Expanded(
                                            child: ListView.builder(
                                                itemCount: snapshot.data.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                      child: QuestionTile(
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
            ),
          ],
        ),
      ),
    );
  }
}
