import 'package:rxdart/rxdart.dart';

class DicussionForumBloc {
  final _likes = PublishSubject<String>();
  final _commentCount = PublishSubject<String>();

  Stream<String> get likesStream => _likes.stream;
  Stream<String> get commentCountStream => _commentCount.stream;

  Function(String) get likes => _likes.sink.add;
  Function(String) get commetCount => _commentCount.sink.add;

  void dispose(){
    _likes.close();
    _commentCount.close();
  }
}