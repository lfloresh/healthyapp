import 'package:flutter/material.dart';
import 'package:testAndroid/widgets/listDrawer.dart';

class GraficosPage extends StatefulWidget {
  @override
  _GraficosPageState createState() => _GraficosPageState();
}

class _GraficosPageState extends State<GraficosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        drawer: listDrawer(context),
        appBar: AppBar(
          title: Text('Gráficos'),
          elevation: 0.0,
          actions: <Widget>[],
        ),
      ),
    );
  }
}
