import 'package:flutter/material.dart';

class DiscussionModel {
  String title;
  String id;
  String creationDate;
  String parentId;
  String score;
  String postType;
  String body;
  String answerCount;
  String closedDate;
  String commentCount;
  String author;
  List<String> tags;

  DiscussionModel.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson["title"],
        id = parsedJson["id"].toString(),
        creationDate = parsedJson["creationDate"],
        commentCount = parsedJson["commentCount"].toString(),
        parentId = parsedJson["parentId"].toString(),
        score = parsedJson["score"].toString(),
        postType = parsedJson["postType"],
        body = parsedJson["body"],
        answerCount = parsedJson["answerCount"].toString(),
        closedDate = parsedJson["closedDate"].toString(),
        author = parsedJson["author"].toString();

  Map<String, dynamic> toMap() => {
        "title": title,
        "postType": postType,
        "parentId": parentId,
        "creationDate": creationDate,
        "score": score,
        "body": body,
        "answerCount": answerCount,
        "commentCount": commentCount,
        "closedDate": closedDate,
        "author": author
      };

  Map<String, dynamic> toMapforDb() => {
        "title": title,
        "postType": postType,
        "parentId": parentId,
        "creationDate": creationDate,
        "score": score,
        "body": body,
        "answerCount": answerCount,
        "commentCount": commentCount,
        "closedDate": closedDate,
        "author": author
      };

  DiscussionModel.fromDb(Map<String, dynamic> parsedJson)
      : title = parsedJson["title"],
        creationDate = parsedJson["creationDate"],
        commentCount = parsedJson["commentCount"],
        parentId = parsedJson["parentId"],
        score = parsedJson["score"],
        postType = parsedJson["postType"],
        body = parsedJson["body"],
        answerCount = parsedJson["answerCount"],
        closedDate = parsedJson["closedDate"],
        author = parsedJson["author"],
        tags = parsedJson["tags"];
}

//title TEXT,
//    postType TEXT,
//parentId: TEXT,
//creationDate: TEXT,
//score INTEGER,
//    body TEXT,
//answerCount INTEGER,
//    commentCount INTEGER,
//closedDate TEXT,
//    author TEXT,
//tags BLOB
