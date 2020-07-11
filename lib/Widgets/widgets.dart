import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ClassroomCard extends StatelessWidget {
  final String imageUrl;
  final String subjectName;
  final String description;
  final double Width;
  final double Height;
  final String sectionName;
  ClassroomCard(
      {this.imageUrl,
      this.subjectName,
      this.Width,
      this.Height,
      this.sectionName,
      this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Column(
        children: <Widget>[
          ImageWithText(
            imageUrl: imageUrl,
            subjectName: subjectName,
            Height: Height,
            Width: Width,
          ),
          SizedBox(height: 25),
          Row(
            children: <Widget>[
              SizedBox(width: 15),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  sectionName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              SizedBox(width: 15),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  description,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.5),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class ImageWithText extends StatelessWidget {
  final String imageUrl, subjectName;
  final double Width, Height;
  ImageWithText({this.imageUrl, this.subjectName, this.Height, this.Width});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: Width,
            height: Height,
          ),
        ),
        Container(
            width: Width,
            height: Height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.black26),
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    subjectName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class DiscussionTile extends StatelessWidget {
  final String imageUrl, subjectName;
  final double Width, Height;
  DiscussionTile({this.imageUrl, this.subjectName, this.Height, this.Width});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: Width,
            height: Height,
          ),
        ),
        Container(
            width: Width,
            height: Height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.black54),
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    subjectName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class HomePageCard extends StatelessWidget {
  final String imageUrl, itemName;
  final double Width, Height;
  HomePageCard({this.imageUrl, this.itemName, this.Height, this.Width});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: Width,
                height: Height,
              ),
            ),
            Container(
              width: Width,
              height: Height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  itemName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<String> assignments;
  TaskList({this.assignments});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
