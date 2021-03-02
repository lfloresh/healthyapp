import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/widgets/styleText.dart';

class Periodo extends StatefulWidget {
  final BuildContext context;
  Periodo({Key key, this.context}) : super(key: key);

  @override
  _PeriodoState createState() => _PeriodoState();
}

class _PeriodoState extends State<Periodo> {
  RegisterParameters opt;
  bool semana;
  bool mes;
  bool dosMeses;
  bool tresMeses;
  bool seisMeses;
  bool anho;
  bool inicio;
  bool todo;
  final ScrollController scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    semana = false;
    mes = false;
    dosMeses = false;
    tresMeses = false;
    seisMeses = false;
    anho = false;
    inicio = false;
    todo = false;
    opt = Provider.of<RegisterParameters>(widget.context);
    switch (opt.periodo) {
      case "1 semana":
        semana = true;
        break;
      case "1 mes":
        mes = true;
        break;
      case "2 meses":
        dosMeses = true;
        break;
      case "3 meses":
        tresMeses = true;
        break;
      case "6 meses":
        seisMeses = true;
        break;
      case "1 año":
        anho = true;
        break;
      case "Desde peso inicial":
        inicio = true;
        break;
      case "Todo":
        todo = true;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: styleText("Período del progreso", 20),
      content: Container(
        height: MediaQuery.of(widget.context).size.height / 2,
        child: Scrollbar(
          isAlwaysShown: true,
          controller: scroll,
          child: SingleChildScrollView(
            controller: scroll,
            child: Column(
              children: [
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("1 semana", 16),
                  value: semana,
                  onChanged: (val) {
                    setState(() {
                      semana = true;
                      mes = false;
                      dosMeses = false;
                      tresMeses = false;
                      seisMeses = false;
                      anho = false;
                      inicio = false;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("1 mes", 16),
                  value: mes,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = true;
                      dosMeses = false;
                      tresMeses = false;
                      seisMeses = false;
                      anho = false;
                      inicio = false;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("2 meses", 16),
                  value: dosMeses,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = false;
                      dosMeses = true;
                      tresMeses = false;
                      seisMeses = false;
                      anho = false;
                      inicio = false;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("3 meses", 16),
                  value: tresMeses,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = false;
                      dosMeses = false;
                      tresMeses = true;
                      seisMeses = false;
                      anho = false;
                      inicio = false;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("6 meses", 16),
                  value: seisMeses,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = false;
                      dosMeses = false;
                      tresMeses = false;
                      seisMeses = true;
                      anho = false;
                      inicio = false;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("1 año", 16),
                  value: anho,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = false;
                      dosMeses = false;
                      tresMeses = false;
                      seisMeses = false;
                      anho = true;
                      inicio = false;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("Desde peso inicial", 16),
                  value: inicio,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = false;
                      dosMeses = false;
                      tresMeses = false;
                      seisMeses = false;
                      anho = false;
                      inicio = true;
                      todo = false;
                    });
                  },
                ),
                CheckboxListTile(
                  activeColor: Colors.green,
                  title: styleText("Todo", 16),
                  value: todo,
                  onChanged: (val) {
                    setState(() {
                      semana = false;
                      mes = false;
                      dosMeses = false;
                      tresMeses = false;
                      seisMeses = false;
                      anho = false;
                      inicio = false;
                      todo = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(widget.context);
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(
            'Cancelar',
            style: TextStyle(color: Color(0xff417505)),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (semana == true) opt.periodo = "1 semana";
            if (mes == true) opt.periodo = "1 mes";
            if (dosMeses == true) opt.periodo = "2 meses";
            if (tresMeses == true) opt.periodo = "3 meses";
            if (seisMeses == true) opt.periodo = "6 meses";
            if (anho == true) opt.periodo = "1 año";
            if (inicio == true) opt.periodo = "Desde peso inicial";
            if (todo == true) opt.periodo = "Todo";
            Navigator.pop(widget.context);
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(
            'Aceptar',
            style: TextStyle(color: Color(0xff417505)),
          ),
        )
      ],
    );
  }
}
