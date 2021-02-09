import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/widgets/styleText.dart';

Widget partOfTheDay(BuildContext context) {
  final option = Provider.of<RegisterParameters>(context);
  return AlertDialog(
    titleTextStyle: TextStyle(color: Colors.white),
    backgroundColor: Color(0xff417505),
    title: styleText("Elige una opción", 20),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          minWidth: 100,
          color: Colors.green[200],
          child: styleText("Desayuno", 15),
          onPressed: () {
            option.option = "Desayuno";
            Navigator.pop(context);
          },
        ),
        FlatButton(
          minWidth: 100,
          color: Colors.green[200],
          child: styleText("Almuerzo", 15),
          onPressed: () {
            option.option = "Almuerzo";
            Navigator.pop(context);
          },
        ),
        FlatButton(
          minWidth: 100,
          color: Colors.green[200],
          child: styleText("Cena", 15),
          onPressed: () {
            option.option = "Cena";
            Navigator.pop(context);
          },
        ),
        FlatButton(
          minWidth: 100,
          color: Colors.green[200],
          child: styleText("Meriendas", 15),
          onPressed: () {
            option.option = "Meriendas";
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
