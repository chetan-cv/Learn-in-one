import 'package:googleapis/classroom/v1.dart';
import "package:googleapis_auth/auth_io.dart";
import "package:http/http.dart" as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

var id = new ClientId(
    "144653325752-glb24615svm5ucjil2kogumg2dton40i.apps.googleusercontent.com",
    "");

var scopes = ['https://www.googleapis.com/auth/classroom.courses.readonly'];

Future<List<Course>> gettingCourses(String accessToken) async {

  ClassroomApi classroom = ClassroomApi(
      oauth2.Client(oauth2.Credentials(accessToken), basicAuth: true));
  return classroom.courses.list().then((list) {
    print(list.courses);
    return list.courses;
  });
}


