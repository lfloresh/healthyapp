import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class GraficosPage extends StatefulWidget {
  GraficosPage({Key key}) : super(key: key);

  @override
  _GraficosPageState createState() => _GraficosPageState();
}

class _GraficosPageState extends State<GraficosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Gráficos"),
        backgroundColor: Color(0xff417505),
      ),
      drawer: listDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ButtonTheme(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                    elevation: 5,
                    focusElevation: 0,
                    color: Colors.white,
                    child: styleText(" CALORÍAS", 20),
                    onPressed: () => {},
                  ),
                ),
                ButtonTheme(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                    elevation: 5,
                    focusElevation: 0,
                    color: Colors.white,
                    child: styleText(" MACROS", 20),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Image.asset("assets/images/circle_chart.png"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.3),
                          top: BorderSide(width: 0.3)),
                    ),
                    child: ListTile(
                      title: styleText('Calorías consumidas', 20),
                      trailing: styleText("0", 18),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.3),
                          top: BorderSide(width: 0.3)),
                    ),
                    child: ListTile(
                      title: styleText('Calorías netas', 20),
                      trailing: styleText("0", 18),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.3),
                          top: BorderSide(width: 0.3)),
                    ),
                    child: ListTile(
                      title: styleText('Objetivo', 20),
                      trailing: styleText("1,670", 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
