import 'package:flutter/material.dart';
import 'package:testAndroid/widgets/listDrawer.dart';

class ObjetivosPage extends StatefulWidget {
  @override
  _ObjetivosPageState createState() => _ObjetivosPageState();
}

class _ObjetivosPageState extends State<ObjetivosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        drawer: listDrawer(context),
        appBar: AppBar(
          title: Text('Objetivos'),
          elevation: 0.0,
          actions: <Widget>[],
        ),
      ),
    );
  }
}
