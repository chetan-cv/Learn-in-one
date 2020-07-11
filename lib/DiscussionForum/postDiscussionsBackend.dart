import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:learninone/DiscussionForum/CommentsModel.dart';

Future uploadingComment(String id, String message) async {
  return await http
      .post('https://learninone.herokuapp.com/post/comment/', body: {
    "postId": id,
    "message": "$message",
//    "postId": 1
  }).then((response) {
    print(response.statusCode);
    return response;
  });
}

Future<List<CommentsModel>> gettingComments() async {
  return await http
      .get('https://learninone.herokuapp.com/post/comment/')
      .then((response) {
//    print(response.statusCode);
    List mappedComments = jsonDecode(response.body)['results'];
    List<CommentsModel> comments = [];
    mappedComments.forEach((element) {
      print(mappedComments[0]);
      comments.add(CommentsModel.fromJson(element));
    });
    return comments;
  });
}


