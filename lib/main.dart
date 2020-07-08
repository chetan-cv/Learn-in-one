import 'package:flutter/material.dart';
import 'package:learninone/learnInOneBackend.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: Scaffold (
        appBar: AppBar (
          title: Center ( child: Text ( "Learn in all" ) ),
        ),
        body: ListView (
          children: <Widget>[
            FutureBuilder<Object> (
                future: getingCourses(),
                builder: (context, snapshot) {
                  return Container (
                  );
                }
            )
          ],
        ),
      ),
    );
  }

}
