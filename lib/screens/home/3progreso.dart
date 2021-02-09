import 'package:flutter/material.dart';
import 'package:healthyapp/widgets/listDrawer.dart';

class ProgresoPage extends StatefulWidget {
  @override
  _ProgresoPageState createState() => _ProgresoPageState();
}

class _ProgresoPageState extends State<ProgresoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        drawer: listDrawer(context),
        appBar: AppBar(
          title: Text('Progreso'),
          elevation: 0.0,
          actions: <Widget>[],
        ),
      ),
    );
  }
}
