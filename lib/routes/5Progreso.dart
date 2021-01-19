import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class ProgresoPage extends StatefulWidget {
  ProgresoPage({Key key}) : super(key: key);

  @override
  _ProgresoPageState createState() => _ProgresoPageState();
}

class _ProgresoPageState extends State<ProgresoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progreso"),
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
                    child: Row(
                      children: [
                        Icon(Icons.bar_chart),
                        styleText(" Grasa", 20),
                      ],
                    ),
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
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        styleText(" Desde inicio", 20),
                      ],
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment(0, 0),
              height: 191,
              child: Image.asset("assets/images/grasa.jpg"),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5)),
              ),
              child: styleText("Entradas", 20),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  styleText("18 Oct. 2018", 20),
                  styleText("16.7%", 20)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  styleText("25 Oct. 2018", 20),
                  styleText("14.9%", 20)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  styleText("1 Nov. 2018", 20),
                  styleText("14.1%", 20)
                ],
              ),
            ),
            ButtonTheme(
              child: RaisedButton(
                color: Colors.green[300],
                child: styleText("Registro", 17),
                onPressed: () => {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
