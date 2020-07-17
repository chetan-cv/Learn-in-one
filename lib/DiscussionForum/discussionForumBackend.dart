import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'classroomModel.dart';

Future<http.Response> postingQuestion(String title, String question) async {
  FlutterSecureStorage _store = FlutterSecureStorage();

  String author = await _store.read(key: 'name');
  print(author);
  return await http.post('https://learninone.herokuapp.com/post/list/', body: {
    "title": title,
    "postType": "Post",
//    "parentId": "None",
    "creationDate": DateTime.now().toIso8601String(),
    "body": question,
    "author": author,
//    "tags": [title]
  }).then((response) {
    print(response.body);
    return response;
  });
}

Future<List<DiscussionModel>> gettingSearchedDiscussion(String title) async {
  print(title);
  return await http
      .get('https://learninone.herokuapp.com/post/list/?search=$title')
      .then((response) {
//    print(response.reasonPhrase);
    List mappedDiscussion = jsonDecode(response.body)['results'];
    List<DiscussionModel> discussions = [];
    mappedDiscussion.forEach((element) {
      print(element["commentCount"]);
      discussions.add(DiscussionModel.fromJson(element));
    });
    return discussions;
  }).catchError((error) {
    print(error);
  });
}

Future<List<DiscussionModel>> gettingDiscussion(String title) async {
  print(title);
  return await http
      .get('https://learninone.herokuapp.com/post/list/?title=$title')
      .then((response) {
//    print(response.reasonPhrase);
    List mappedDiscussion = jsonDecode(response.body)['results'];
    List<DiscussionModel> discussions = [];
    mappedDiscussion.forEach((element) {
      print(element["title"]);
      discussions.add(DiscussionModel.fromJson(element));
    });
    return discussions;
  }).catchError((error) {
    print(error);
  });
}

Future<void> likingPost(DiscussionModel post) async {
  print('hello');
  int score = int.parse(post.score) + 1;
  await http.put(
    Uri.encodeFull('https://learninone.herokuapp.com/post/list/${post.id}/'),
    body: {
      "score": score.toString()
    }
  );

}
