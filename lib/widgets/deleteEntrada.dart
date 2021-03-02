import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/styleText.dart';

class DeleteEntrada extends StatefulWidget {
  final String fecha;
  DeleteEntrada({Key key, this.fecha}) : super(key: key);

  @override
  _DeleteEntradaState createState() => _DeleteEntradaState();
}

class _DeleteEntradaState extends State<DeleteEntrada> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    return AlertDialog(
      title: styleText("¿Borrar Entrada?", 20),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Borrar",
            style: TextStyle(color: Color(0xff417505)),
          ),
          onPressed: () async {
            db.deleteEntrada(widget.fecha);
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            "Atras",
            style: TextStyle(color: Color(0xff417505)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
