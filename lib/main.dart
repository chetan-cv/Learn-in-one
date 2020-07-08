import 'package:flutter/material.dart';
import 'package:googleapis/classroom/v1.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Learn in all")),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Center(
                      child: Text(
                    'Courses',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder<List<Course>>(
                      future: getingCourses(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState == ConnectionState.done
                            ? Container(
                                child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Container(
                                          height: 200.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                  child: Text(
                                                      '${snapshot.data[index].name}'))
                                            ],
                                          ),
                                        ),
                                      );
                                    }))
                            : Container(
                                height: 100.0,
                                width: 100.0,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
