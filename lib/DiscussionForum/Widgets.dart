import 'package:flutter/material.dart';
import 'package:learninone/DiscussionForum/CommentsModel.dart';
import 'package:learninone/DiscussionForum/classroomModel.dart';
import 'package:learninone/DiscussionForum/discussionForumBackend.dart';
import 'package:learninone/DiscussionForum/postDiscussions.dart';

Widget QuestionTile(AsyncSnapshot<List<DiscussionModel>> snapshot, int index,
    BuildContext context) {
  return ListTile(
    title: Container(
//      color: Colors.red,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${snapshot.data[index].title}',
            style: TextStyle(color: Colors.grey),
          ),
          Text('${snapshot.data[index].body}'),
        ],
      ),
    ),
    subtitle: Container(
//        color: Colors.blue,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('${snapshot.data[index].author}'),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostDiscussions(snapshot.data[index]))),
          child: Container(
            width: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.message),
                Text('${snapshot.data[index].commentCount}'),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => likingPost(snapshot.data[index])
              .whenComplete(
              () => context.findAncestorStateOfType().setState(() {})),
          child: Container(
            width: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.add_box, size: 30.0,),
                Text('${snapshot.data[index].score}'),
              ],
            ),
          ),
        ),
      ],
    )),
  );
}

Widget CommentTile(AsyncSnapshot<List<CommentsModel>> snapshot, int index,
    BuildContext context) {
  return ListTile(
    title: Container(
//      color: Colors.red,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${snapshot.data[index].message}',
            style: TextStyle(color: Colors.grey),
          ),
//          Text('${snapshot.data[index].body}'),
        ],
      ),
    ),
    subtitle: Container(
//        color: Colors.blue,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
//        Text('${snapshot.data[index].author}'),
//        GestureDetector(
//          onTap: () => Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => PostDiscussions(snapshot.data[index]))),
//          child: Container(
//            width: 50.0,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Icon(Icons.message),
////                Text('${snapshot.data[index].commentCount}'),
//              ],
//            ),
//          ),
//        ),
//        Container(
//          width: 50.0,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              Icon(Icons.add_box),
//              Text('${snapshot.data[index].score}'),
//            ],
//          ),
//        ),
      ],
    )),
  );
}
