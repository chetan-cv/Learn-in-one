import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DiscussionRoom.dart';

class DiscussionForum extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DiscussionForumState();
  }
}

class DiscussionForumState extends State<DiscussionForum> {
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text('Discussion Forum', style: TextStyle(fontSize: 30.0),),
                ),
                Container(height: 30.0,),
                Container(
                  child: Text('Choose topic', style: TextStyle(fontSize: 20.0),),
                ),
                Container(height: 30.0,),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      itemCount: tags.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2.0),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DiscussionRoom(tag: tags[index]))),
                          child: GridTile(
                              child: Card(
                                  elevation: 2.0,
                                  child: Center(
                                      child: Text(
                                    tags[index],
                                    textAlign: TextAlign.center,
                                  )))),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
