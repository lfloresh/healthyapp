import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/entrada.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/screens/home/13addEntrada.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/deleteEntrada.dart';
import 'package:healthyapp/widgets/listDrawer.dart';
import 'package:healthyapp/widgets/loading.dart';
import 'package:healthyapp/widgets/periodo.dart';
import 'package:healthyapp/widgets/styleText.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgresoPage extends StatefulWidget {
  @override
  _ProgresoPageState createState() => _ProgresoPageState();
}

class _ProgresoPageState extends State<ProgresoPage> {
  List<charts.Series<Entrada, DateTime>> _seriesLineData;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    final objetivos = Provider.of<Objetivos>(context, listen: false);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        drawer: listDrawer(context),
        appBar: AppBar(
          title: Text('Progreso'),
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(51.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration:
                        BoxDecoration(border: Border(right: BorderSide())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart),
                        styleText("Peso", 15),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          Consumer<RegisterParameters>(
                              builder: (_, opt, __) =>
                                  Flexible(child: styleText(opt.periodo, 15))),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Periodo(
                            context: context,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<RegisterParameters>(
                builder: (_, opt, __) {
                  var periodo;
                  var hoy = DateTime.now();
                  switch (opt.periodo) {
                    case "1 semana":
                      periodo = DateTime(hoy.year, hoy.month, hoy.day - 6);
                      break;
                    case "1 mes":
                      periodo = DateTime(hoy.year, hoy.month, hoy.day - 29);
                      break;
                    case "2 meses":
                      periodo = DateTime(hoy.year, hoy.month, hoy.day - 58);
                      break;
                    case "3 meses":
                      periodo = DateTime(hoy.year, hoy.month, hoy.day - 87);
                      break;
                    case "6 meses":
                      periodo = DateTime(hoy.year, hoy.month, hoy.day - 174);
                      break;
                    case "1 año":
                      periodo = DateTime(hoy.year, hoy.month, hoy.day - 364);
                      break;
                    case "Desde peso inicial":
                      periodo = DateTime.parse(
                          objetivos.date.split('-').reversed.join());
                      break;
                    case "Todo":
                      periodo = DateTime.parse(
                          objetivos.menorFecha.split('-').reversed.join());
                      break;
                  }
                  periodo = DateFormat("yyyy-MM-dd").format(periodo);
                  return FutureBuilder<List<Entrada>>(
                    future: db.entradas(periodo),
                    builder: (_, entradas) {
                      if (entradas.connectionState == ConnectionState.waiting ||
                          entradas.connectionState == ConnectionState.none)
                        return Loading();
                      if (entradas.hasData) {
                        _seriesLineData =
                            List<charts.Series<Entrada, DateTime>>();
                        _seriesLineData.add(
                          charts.Series<Entrada, DateTime>(
                            colorFn: (__, _) => charts.ColorUtil.fromDartColor(
                                Color(0xffff9900)),
                            id: 'Air Pollution',
                            data: entradas.data,
                            domainFn: (Entrada entrada, _) =>
                                DateTime.parse(entrada.fecha.split('-').join()),
                            measureFn: (Entrada entrada, _) => entrada.peso,
                          ),
                        );
                        return Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height / 2,
                          child: charts.TimeSeriesChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: false,
                              behaviors: [
                                new charts.ChartTitle('Fecha',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Peso',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ]),
                        );
                      }
                      return Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 2,
                      );
                    },
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff417505),
                    border: Border(
                        bottom: BorderSide(color: Colors.grey),
                        top: BorderSide(color: Colors.grey))),
                child: ListTile(
                  leading: Text(
                    "Entradas",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  trailing: Consumer<Objetivos>(
                    builder: (_, obj, __) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEntrada(
                                    objetivos: obj,
                                  )),
                        );
                      },
                      child: Text(
                        "Añadir entrada",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Entrada>>(
                future: db.allEntradas(),
                builder: (_, entradas) {
                  if (entradas.connectionState == ConnectionState.waiting ||
                      entradas.connectionState == ConnectionState.none)
                    return Loading();
                  if (entradas.hasData) {
                    final list = entradas.data.reversed.toList();
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (_, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: FlatButton(
                              onPressed: () {},
                              onLongPress: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => DeleteEntrada(
                                        fecha: list[index].fecha));
                                setState(() {});
                              },
                              child: ListTile(
                                title: styleText(
                                    DateFormat.yMMMd("es-ES").format(
                                        DateTime.parse(list[index]
                                            .fecha
                                            .split("-")
                                            .join())),
                                    18),
                                subtitle:
                                    styleText("${list[index].peso} kg", 15),
                              ),
                            ),
                          );
                        });
                  }
                  return Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 2,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
