import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class ObjetivosPage extends StatefulWidget {
  ObjetivosPage({Key key}) : super(key: key);

  @override
  _ObjetivosPageState createState() => _ObjetivosPageState();
}

class _ObjetivosPageState extends State<ObjetivosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Objetivos"),
        backgroundColor: Color(0xff417505),
      ),
      drawer: listDrawer(context),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 0.3))),
            child: ListTile(
              title: styleText('Peso inicial', 20),
              trailing: styleText("68 kg el 2 Sep. 2018", 18),
              onTap: () {},
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 0.3))),
            child: ListTile(
              title: styleText('Peso actual', 20),
              trailing: styleText("63 kg", 18),
              onTap: () {},
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 0.3))),
            child: ListTile(
              title: styleText('Peso deseado', 20),
              trailing: styleText("60 kg", 18),
              onTap: () {},
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 0.3))),
            child: ListTile(
              title: styleText('Objetivo semanal', 20),
              trailing: styleText("Perder 0.5 kg por semana", 18),
              onTap: () {},
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 60,
            color: Colors.grey[300],
            child: styleText("Objetivos Nutricionales/día", 20),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.3), top: BorderSide(width: 0.3)),
            ),
            child: ListTile(
              title: styleText('Calorías', 20),
              trailing: styleText("1,670", 18),
              onTap: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.3), top: BorderSide(width: 0.3)),
            ),
            child: ListTile(
              title: styleText('Carbohidratos 209g', 20),
              trailing: styleText("50%", 18),
              onTap: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.3), top: BorderSide(width: 0.3)),
            ),
            child: ListTile(
              title: styleText('Proteínas 84g', 20),
              trailing: styleText("20%", 18),
              onTap: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.3), top: BorderSide(width: 0.3)),
            ),
            child: ListTile(
              title: styleText('Grasas 56g', 20),
              trailing: styleText("30%", 18),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
