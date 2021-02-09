import 'package:flutter/material.dart';
import 'package:testAndroid/widgets/styleText.dart';

Widget buildPopUpDialog(BuildContext context) {
  return AlertDialog(
    title: styleText("Descripción", 20),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        styleText("Calorías Objetivo", 18),
        SizedBox(height: 10),
        styleText(
            "Representa la cantidad de calorías netas diarias que debemos obtener.",
            15),
        SizedBox(height: 10),
        styleText("Calorías Alimento", 18),
        SizedBox(height: 10),
        styleText(
            "Representa la cantidad de calorías que ya hemos obtenido al consumir alimentos.",
            15),
        SizedBox(height: 10),
        styleText("Calorías Ejercicio", 18),
        SizedBox(height: 10),
        styleText(
            "Representa la cantidad de calorías que hemos perdido/quemado al hacer ejercicio.",
            15),
        SizedBox(height: 10),
        styleText("Calorías Restantes", 18),
        SizedBox(height: 10),
        styleText(
            "Representa la cantidad de calorías faltantes para completar nuestro objetivo diario.",
            15),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('OK'),
      ),
    ],
  );
}
