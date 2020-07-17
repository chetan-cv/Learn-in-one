import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learninone/DiscussionForum/CommentsModel.dart';

Future uploadingComment(String id, String message) async {
  return await http
      .post('https://learninone.herokuapp.com/post/comment/', body: {
    "postId": id,
    "message": "$message",
  }).then((response) async {
    await increasingCommentCount(id);
    print('aasdasdas${response.statusCode}');
    return response;
  });
}

Future increasingCommentCount(String postId) async {
  await gettingCommentCount(postId).then((commentCount) async {
    await http.put('https://learninone.herokuapp.com/post/list/$postId/', body: {
      "commentCount": (int.parse(commentCount) + 1).toString(),
    }).then((count) {
      print(count.statusCode);
    });
  });
}

Future<String> gettingCommentCount(String id) async {
  String commentCount;
  return await http
      .get('https://learninone.herokuapp.com/post/list/?id=$id')
      .then((response) {
    commentCount =
        jsonDecode(response.body)['results'][0]["commentCount"].toString();
    return commentCount;
  });
}

Future<List<CommentsModel>> gettingComments(String id) async {
  return await http
      .get('https://learninone.herokuapp.com/post/comment/?postId=$id')
      .then((response) {
    List mappedComments = jsonDecode(response.body)['results'];
    List<CommentsModel> comments = [];
    print(mappedComments[0]);
    mappedComments.forEach((element) {
      comments.add(CommentsModel.fromJson(element));
    });
    return comments;
  });
}
