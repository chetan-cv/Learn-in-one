class CommentsModel {
  String message;
  String postID;

  CommentsModel.fromJson(Map<String, dynamic> parsedJson)
      : message = parsedJson["message"],
        postID = parsedJson["postId"].toString();

  Map<String, dynamic> toMap() => {"message": message, "postId": postID};
}
