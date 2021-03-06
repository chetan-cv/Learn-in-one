import 'package:flutter/material.dart';
import 'package:googleapis/classroom/v1.dart';
import 'package:learninone/Widgets/widgets.dart';
import 'classroomBackend.dart';

class Classroom extends StatefulWidget {
  String accessToken;
  Classroom(this.accessToken);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassroomState();
  }
}

class ClassroomState extends State<Classroom> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'My Classrooms',
                  style: TextStyle(fontSize: 40.0,fontFamily: 'Yellowtail',color: Colors.blue),
                ),
              ),
              Container(
                height: 30.0,
              ),
              Expanded(
                child: Container(
//            height: MediaQuery.of(context).size.height,
                  child: FutureBuilder<List<Course>>(
                      future: gettingCourses(widget.accessToken),
                      builder: (context, snapshot) {
                        return snapshot.connectionState == ConnectionState.done
                            ? snapshot.data != null
                                ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:ClassroomCard(
                                                  imageUrl:
                                                      "https://www.revolutioninter.net/wp-content/uploads/2018/09/undraw_blogging_vpvv.png",
                                                  subjectName:
                                                      "${snapshot.data[index].name}",
//                        Width: 300,       
                                                  Height: 200,
                                                  Width: double.infinity,
                                                  sectionName: "${snapshot.data[index].section}",
                                                  description: "${snapshot.data[index].description}",
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          );
                                        }),
                                  )
                                : Center(
                                    child: RaisedButton(
                                        color: Colors.blue,
                                        child: Text(
                                          'Retry',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => setState(() {})),
                                  )
                            : Center(
                                child: Container(
                                  height: 100.0,
                                  width: 100.0,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
