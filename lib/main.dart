import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Classroom/classroom.dart';
import 'DiscussionForum/discussionForum.dart';
import 'Econtent/econtent.dart';
import 'Widgets/widgets.dart';

List<String> assignments = ['1', '2', '3', '4', '5', '6'];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterSecureStorage _store = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Center(
                child: Text(
              "Learn in one",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Yellowtail',
                  fontSize: 42,
                  fontWeight: FontWeight.w500),
            )),
          ),
          body: Container(
            color: Colors.white,
            height: double.infinity,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Your Assignments",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 20),
                    TaskList(assignments: assignments),
                    SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                        future: _store.read(key: "accessToken"),
                        builder: (context, snapshot) {
                          return GestureDetector(
                              onTap: () async => snapshot.data != null
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Classroom(snapshot.data)))
                                  : await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Login please'),
                                            content: RaisedButton(
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () async =>
                                                    await googleSignIn()),
                                          )),
                              child: HomePageCard(
                                imageUrl:
                                    "https://cdn-res.keymedia.com/cms/images/au/130/0314_637232847506093449.jpg",
                                itemName: "Your Classrooms",
                                Width: 300,
                                Height: 200,
                              ));
                        }),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscussionForum())),
                      child: HomePageCard(
                        imageUrl:
                            "https://www.revolutioninter.net/wp-content/uploads/2018/09/undraw_blogging_vpvv.png",
                        itemName: "Discussion Forum",
                        Width: 300,
                        Height: 200,
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EcontentPage())),
                      child: HomePageCard(
                        imageUrl:
                            "https://image.freepik.com/free-vector/online-news_23-2147509495.jpg",
                        itemName: "E-Content",
                        Width: 300,
                        Height: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/classroom.courses.readonly',
        ],
        clientId:
            '144653325752-cs1mrh5f5ekshm2juqocob0jstrmh81b.apps.googleusercontent.com');

    GoogleSignInAccount user = await _googleSignIn.signIn().catchError((error) {
      print(error);
    });
    print('qwehqkwjekabewkjb ${user.displayName}');
    await _store.write(key: 'name', value: user.displayName);
    await _store.write(key: 'email', value: user.email);
    await _store.write(key: 'url', value: user.photoUrl);

    String name = await _store.read(key: 'name');
    print(name);

    GoogleSignInAuthentication auth = await user.authentication;
    await _store.write(key: 'accessToken', value: auth.accessToken);
  }
}
