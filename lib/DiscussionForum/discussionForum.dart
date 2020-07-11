import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learninone/DiscussionForum/Widgets.dart';
import 'package:learninone/DiscussionForum/classroomModel.dart';
import 'package:learninone/DiscussionForum/discussionForumBackend.dart';
import 'DiscussionRoom.dart';
import 'package:learninone/Widgets/widgets.dart';

class DiscussionForum extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DiscussionForumState();
  }
}

class DiscussionForumState extends State<DiscussionForum> {
  TextEditingController _searchedString = TextEditingController(text: '');
  String searchedString = '';
  List<String> tags = [
    "Physics",
    "Chemistry",
    "Maths",
    "Civics",
    "Geography",
    "History",
    "Computer\nScience",
    "Home\nScience",
    "Biology",
    "English",
    "Economics",
    "Political\nScience",
    "Hindi"
  ];
  List<String> urls = [
    "https://images.theconversation.com/files/191827/original/file-20171025-25516-g7rtyl.jpg?ixlib=rb-1.1.0&rect=0%2C70%2C7875%2C5667&q=45&auto=format&w=926&fit=clip",
    "https://jobs.newscientist.com/getasset/c40a5488-11be-43b0-843f-a2e6ef9f0612/",
    "https://s3-us-west-2.amazonaws.com/asset.plexuss.com/department/header/mathematics-degree-programs.jpg",
    "https://www.proprofs.com/quiz-school/topic_images/p19l3do37p3fa7521out19a31mf73.jpg",
    "https://thumbs.dreamstime.com/b/set-geography-symbols-equipments-web-banners-vintage-outline-sketch-web-banners-doodle-style-education-concept-back-to-136641038.jpg",
    "https://media.istockphoto.com/vectors/open-book-with-history-doodles-and-lettering-vector-id1092170968?k=6&m=1092170968&s=612x612&w=0&h=j_qReeZ6d-7T8fXChMTqHS3EAKc_WICk2XLLfwbonfQ=",
    "https://content.techgig.com/photo/75633535/take-these-8-courses-to-excel-in-computer-science.jpg?552620",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRIee7QXw-f3tMcnNiSWjMQWG4XSpeFnxTy7g&usqp=CAU",
    "https://d9np3dj86nsu2.cloudfront.net/image/00b38680b9582e23fa2f92f990d2d182",
    "https://previews.123rf.com/images/luplupme/luplupme1907/luplupme190700594/129453972-british-english-language-learning-class-vector-illustration-brittish-flag-logo-england-dictionary-bi.jpg",
    "https://m.jagranjosh.com/imported/images/E/Articles/Economics-for-UPSC.jpg",
    "https://dubeat.com/wp-content/uploads/2019/06/sciencespo.fr_.jpeg",
    "https://www.thestatesman.com/wp-content/uploads/2019/09/QT-O2-9.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  'Discussion Forum',
                  style: TextStyle(fontSize: 40.0,color: Colors.blue,fontFamily: 'Yellowtail',),
                ),
              ),
            ),
//            Container(
//              height: 30.0,
//            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
//                  height: 100,
                width: MediaQuery.of(context).size.width,
                child: Container(
//                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Search topic',
                                      border: InputBorder.none),
                                  controller: _searchedString,
                                  onEditingComplete: () =>
                                      searchedString = _searchedString.text,
                                  onChanged: (value) =>
                                      searchedString = _searchedString.text,
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchedString = _searchedString.text;
                                    });
                                  },
                                  child: Container(
                                      child: Icon(
                                    Icons.search,
                                    size: 32,
                                  )))
                            ],
                          ))),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DiscussionModel>>(
                  future: gettingSearchedDiscussion(searchedString),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
//                      height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Choose topic',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Container(
                              height: 30.0,
                            ),
                            searchedString == ''
                                ? Expanded(
                                    child: Container(
                                      child: GridView.builder(
                                        itemCount: tags.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 2.0),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DiscussionRoom(
                                                            tag: tags[index]))),
                                            child: GridTile(
                                              child: Container(
                                                margin: EdgeInsets.only(right:10,bottom: 10),
                                                child: DiscussionTile(
                                                  imageUrl: urls[index],
                                                  subjectName: tags[index],
                                                  Height: 250,
                                                  Width: 300,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : snapshot.connectionState ==
                                        ConnectionState.done
                                    ? snapshot.data != null
                                        ? Expanded(
                                            child: ListView.builder(
                                                itemCount: snapshot.data.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                      child: QuestionTile(
                                                          snapshot, index));
                                                }),
                                          )
                                        : Container(
                                            child: Text('no results found'),
                                          )
                                    : Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
