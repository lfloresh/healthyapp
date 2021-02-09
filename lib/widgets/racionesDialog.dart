import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testAndroid/Notifiers/registerParameters.dart';
import 'package:testAndroid/models/alimento.dart';
import 'package:testAndroid/widgets/styleText.dart';
import 'package:flutter/services.dart';

class RacionesDialog extends StatefulWidget {
  final Alimento alimento;
  final BuildContext context;
  RacionesDialog({Key key, this.alimento, this.context}) : super(key: key);

  @override
  _RacionesDialogState createState() => _RacionesDialogState();
}

class _RacionesDialogState extends State<RacionesDialog> {
  RegisterParameters option;
  Map racion;
  double raciones;

  @override
  void initState() {
    super.initState();
    option = Provider.of<RegisterParameters>(widget.context);
    racion = option.racion;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: styleText("¿Cuánto?", 23),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 40,
                child: TextField(
                  decoration:
                      InputDecoration(hintText: option.nraciones.toString()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    setState(
                      () {
                        raciones = double.parse(value);
                      },
                    );
                  },
                ),
              ),
              styleText("Ración(es) de", 20)
            ],
          ),
          DropdownButton<Map>(
            isExpanded: true,
            style: TextStyle(color: Colors.black),
            items: widget.alimento.raciones.map<DropdownMenuItem<Map>>((value) {
              return DropdownMenuItem<Map>(
                value: value,
                child: Text("${value["tamaño"]} ${value["medida"]}"),
              );
            }).toList(),
            hint: Text(
              "${racion["tamaño"]} ${racion["medida"]}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (value) {
              setState(
                () {
                  racion = value;
                },
              );
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (raciones != null) option.nraciones = raciones;
            if (racion != null) option.racion = racion;
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(
            'OK',
            style: TextStyle(color: Color(0xff417505)),
          ),
        )
      ],
    );
  }
}
