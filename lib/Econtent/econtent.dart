import 'package:flutter/material.dart';
import 'package:learninone/Widgets/widgets.dart';

class EcontentPage extends StatefulWidget {
  @override
  _EcontentPageState createState() => _EcontentPageState();
}

class _EcontentPageState extends State<EcontentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("E-Content",style: TextStyle(color:Colors.blue,fontSize: 40,fontFamily: 'Yellowtail'),)),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );

  }
}