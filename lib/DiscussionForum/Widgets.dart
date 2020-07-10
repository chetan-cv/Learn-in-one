import 'package:flutter/material.dart';

Widget QuestionTile(AsyncSnapshot snapshot, index){

  return ListTile(
    title: Center(
        child:
        Text('${snapshot.data[index].body}')),
    subtitle: Text('${snapshot.data[index].title}'),
  );

}