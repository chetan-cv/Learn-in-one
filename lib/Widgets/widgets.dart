import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ClassroomCard extends StatelessWidget {
  final String imageUrl;
  final String subjectName;
  final double Width;
  final double Height;
  ClassroomCard({this.imageUrl, this.subjectName,this.Width,this.Height});
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
          Align(
            alignment: Alignment.bottomLeft,
                      child: Text(
              "X-D",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500, fontSize: 30),
            ),
          )
        ],
      )),
    );
  }
}

class ImageWithText extends StatelessWidget {
  final String imageUrl, subjectName;
  final double Width,Height;
  ImageWithText({this.imageUrl, this.subjectName,this.Height,this.Width});
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
          child: Align(
            alignment: Alignment.bottomLeft,
                      child: Text(
              subjectName,
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
