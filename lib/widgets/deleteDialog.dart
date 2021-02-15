import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/styleText.dart';

class DeleteDialog extends StatefulWidget {
  final int index;
  DeleteDialog({Key key, this.index}) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final opt = Provider.of<RegisterParameters>(context, listen: false);
    final user = Provider.of<UserModel>(context);
    final db = DatabaseService(uid: user.uid);
    final page = Provider.of<CurrentPage>(context);
    return AlertDialog(
      title: styleText("¿Borrar Entrada?", 20),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Borrar",
            style: TextStyle(color: Color(0xff417505)),
          ),
          onPressed: () async {
            opt.index = widget.index;
            await db.deleteFood(opt);
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
            page.page = "Home";
            page.page = "Registros";
          },
        )
      ],
    );
  }
}
