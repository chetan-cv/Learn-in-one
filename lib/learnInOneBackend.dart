import 'package:googleapis/classroom/v1.dart';
import "package:googleapis_auth/auth_io.dart";
import "package:http/http.dart" as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

var id = new ClientId(
    "144653325752-glb24615svm5ucjil2kogumg2dton40i.apps.googleusercontent.com",
    "");

var scopes = ['https://www.googleapis.com/auth/classroom.courses.readonly'];

Future<List<Course>> getingCourses() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/classroom.courses.readonly',
      ],
      clientId:
          '144653325752-cs1mrh5f5ekshm2juqocob0jstrmh81b.apps.googleusercontent.com');
  GoogleSignInAccount user = await _googleSignIn.signIn();
  GoogleSignInAuthentication auth = await user.authentication;
  await gettingDiscussion();
  ClassroomApi classroom = ClassroomApi(
      oauth2.Client(oauth2.Credentials(auth.accessToken), basicAuth: true));
  return classroom.courses.list().then((list) {
    print(list.courses);
    return list.courses;
  });
}

Future gettingDiscussion() async {
  http.get('https://learninone.herokuapp.com/post/list/').then((response){
    print(response.body);
  });
}

//Future courses() async {
//  var classroom = ClassroomApi(client, rootUrl: 'https://www.googleapis.com/auth/classroom.courses.readonly');
//  classroom.courses.list().then((list){
//    print(list);
//  });
//}
