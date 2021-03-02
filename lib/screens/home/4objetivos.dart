import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/listDrawer.dart';
import 'package:healthyapp/widgets/styleText.dart';
import 'package:intl/intl.dart';

class ObjetivosPage extends StatefulWidget {
  @override
  _ObjetivosPageState createState() => _ObjetivosPageState();
}

class _ObjetivosPageState extends State<ObjetivosPage> {
  final _formKey = GlobalKey<FormState>();

  double pInicial;
  double pActual;
  double pDeseado;
  double calDiarias;
  double carDiarias;
  double proDiarias;
  double graDiarias;
  String date;
  String menorFecha;

  @override
  void initState() {
    super.initState();
    var obj = Provider.of<Objetivos>(context, listen: false);
    pInicial = obj.pInicial;
    pActual = obj.pActual;
    pDeseado = obj.pDeseado;
    calDiarias = obj.calDiarias;
    carDiarias = obj.carDiarias;
    proDiarias = obj.proDiarias;
    graDiarias = obj.graDiarias;
    date = obj.date;
    menorFecha = obj.menorFecha;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final db = DatabaseService(uid: user.uid);
    final page = Provider.of<CurrentPage>(context);
    return Scaffold(
      backgroundColor: Colors.green[100],
      drawer: listDrawer(context),
      appBar: AppBar(
        title: Text('Objetivos'),
        elevation: 10,
        actions: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: styleText("Actualizar", 20),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  Map objetivos = {
                    "pInicial": pInicial == null ? 0 : pInicial,
                    "pActual": pActual == null ? 0 : pActual,
                    "pDeseado": pDeseado == null ? 0 : pDeseado,
                    "calDiarias": calDiarias == null ? 0 : calDiarias,
                    "carDiarias": carDiarias == null ? 0 : carDiarias,
                    "proDiarias": proDiarias == null ? 0 : proDiarias,
                    "graDiarias": graDiarias == null ? 0 : graDiarias,
                    "date": date == null
                        ? DateFormat("dd-MM-yyyy").format(DateTime.now())
                        : date,
                    "menorFecha": menorFecha == null
                        ? DateFormat("dd-MM-yyyy").format(DateTime.now())
                        : menorFecha,
                  };
                  await db.setObjectives(objetivos);

                  Map entradaI = {
                    "peso": pInicial == null ? 0 : pInicial,
                    "fecha": date == null
                        ? DateFormat("yyyy-MM-dd").format(DateTime.now())
                        : date.split('-').reversed.join('-')
                  };
                  await db.setEntrada(entradaI);
                  Map entrada = {
                    "peso": pActual == null ? 0 : pActual,
                    "fecha": DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  };
                  await db.setEntrada(entrada);
                  page.page = "Home";
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<Objetivos>(builder: (_, obj, __) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.only(top: 15, right: 5, left: 5),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        color: Color(0xff417505),
                        child: Text("Objetivos físicos",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Peso inicial (kg)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.pInicial.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) => setState(
                                    () => pInicial = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Fecha inicio",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: 100,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                child: styleText(date, 15),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    locale: const Locale("es", "ES"),
                                    currentDate: DateTime.now(),
                                    initialDate: DateTime.parse(
                                        obj.date.split('-').reversed.join()),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Color(0xff417505),
                                            onPrimary: Colors.white,
                                            surface: Color(0xff417505),
                                            onSurface: Colors.white,
                                          ),
                                          dialogBackgroundColor: Colors.green,
                                        ),
                                        child: child,
                                      );
                                    },
                                  ).then((dateSelected) {
                                    if (dateSelected != null)
                                      setState(() {
                                        date = DateFormat("dd-MM-yyyy")
                                            .format(dateSelected);
                                        if (DateTime.parse(obj.menorFecha
                                                    .split('-')
                                                    .reversed
                                                    .join())
                                                .compareTo(dateSelected) >
                                            0) menorFecha = date;
                                      });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Peso actual (kg)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.pActual.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) =>
                                    setState(() => pActual = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Peso deseado (kg)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.pDeseado.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) => setState(
                                    () => pDeseado = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(top: 15, right: 5, left: 5),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        color: Color(0xff417505),
                        child: Text("Objetivos nutricionales(diarios)",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Container(
                        height: 70,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Calorias",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.calDiarias.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) => setState(
                                    () => calDiarias = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Carbohidratos (g)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.carDiarias.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) => setState(
                                    () => carDiarias = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Proteínas(g)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.proDiarias.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) => setState(
                                    () => proDiarias = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Grasas (g)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 5,
                              child: TextFormField(
                                initialValue: obj.graDiarias.toStringAsFixed(0),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Requerido",
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "Requerido" : null,
                                onChanged: (val) => setState(
                                    () => graDiarias = double.parse(val)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
