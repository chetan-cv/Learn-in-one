import 'package:flutter/material.dart';
import 'package:googleapis/classroom/v1.dart';
import 'package:learninone/learnInOneBackend.dart';
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
                    SizedBox(height:20),
                    Container(margin:EdgeInsets.only(left:10),child: Text("Your Assignments",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: assignments.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              width: 100,
                              child: Card(
                                color: Colors.blue,
                                elevation: 1.5,
                                child: Center(
                                  child: Text(
                                    assignments[index],
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    HomePageCard(
                      imageUrl:
                          "https://cdn-res.keymedia.com/cms/images/au/130/0314_637232847506093449.jpg",
                      itemName: "Your Classrooms",
                      Width: 300,
                      Height: 200,
                    ),
                    SizedBox(height: 30),
                    HomePageCard(
                      imageUrl:
                          "https://www.revolutioninter.net/wp-content/uploads/2018/09/undraw_blogging_vpvv.png",
                      itemName: "Discussion Forum",
                      Width: 300,
                      Height: 200,
                    ),
                    SizedBox(height: 30),
                    HomePageCard(
                      imageUrl:
                          "https://image.freepik.com/free-vector/online-news_23-2147509495.jpg",
                      itemName: "E-Content",
                      Width: 300,
                      Height: 200,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
