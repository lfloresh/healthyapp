import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:intl/intl.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:healthyapp/models/registerDay.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/screens/home/11addTraining.dart';
import 'package:healthyapp/screens/home/12updateTraining.dart';
import 'package:healthyapp/screens/home/9updateFood.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/deleteDialog.dart';
import 'package:healthyapp/widgets/deleteTraining.dart';
import 'package:healthyapp/widgets/listDrawer.dart';
import 'package:healthyapp/widgets/loading.dart';
import 'package:healthyapp/widgets/styleText.dart';

class RegistrosPage extends StatefulWidget {
  @override
  _RegistrosPageState createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  @override
  Widget build(BuildContext context) {
    final option = Provider.of<RegisterParameters>(context, listen: false);
    final page = Provider.of<CurrentPage>(context, listen: false);
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        drawer: listDrawer(context),
        appBar: AppBar(
          title: Text('Registros'),
          elevation: 0.0,
          actions: <Widget>[],
          bottom: PreferredSize(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]),
                    ),
                    color: Colors.white,
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FlatButton(
                          onPressed: () {
                            option.date = DateTime(option.date.year,
                                option.date.month, option.date.day - 1);
                          },
                          child: Icon(
                            Icons.arrow_left,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              locale: const Locale("es", "ES"),
                              currentDate: DateTime.now(),
                              initialDate: option.date,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2100),
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
                            ).then((date) {
                              if (date != null) option.date = date;
                              print(
                                  DateFormat("dd-MM-yyyy").format(option.date));
                            });
                          },
                          child: Consumer<RegisterParameters>(
                            builder: (_, date, widget) => DateFormat(
                                            "dd-MM-yyyy")
                                        .format(DateTime.now()) ==
                                    DateFormat("dd-MM-yyyy").format(date.date)
                                ? styleText("Hoy", 20)
                                : styleText(
                                    DateFormat.yMMMd("es_PE").format(date.date),
                                    20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: FlatButton(
                          onPressed: () {
                            option.date = DateTime(option.date.year,
                                option.date.month, option.date.day + 1);
                          },
                          child: Icon(
                            Icons.arrow_right,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<RegisterParameters>(builder: (_, opti, wid) {
                  db.dia = DateFormat("dd-MM-yyyy").format(opti.date);
                  return StreamProvider<RegisterDay>.value(
                    value: db.registerDay,
                    initialData: RegisterDay(
                        almuerzo: [],
                        calorias: 0,
                        cena: [],
                        desayuno: [],
                        meriendas: [],
                        calEjercicio: 0,
                        ejercicio: []),
                    catchError: (_, __) => RegisterDay(
                        almuerzo: [],
                        calorias: 0,
                        cena: [],
                        desayuno: [],
                        meriendas: [],
                        calEjercicio: 0,
                        ejercicio: []),
                    child: Container(
                      height: 100,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          styleText("Calorías restantes", 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Consumer<Objetivos>(
                                      builder: (_, obj, __) => styleText(
                                          obj.calDiarias.toStringAsFixed(2),
                                          18)),
                                  Divider(),
                                  styleText("Objetivo", 15)
                                ],
                              ),
                              Column(
                                children: [
                                  styleText("-", 20),
                                  Divider(),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  Consumer<RegisterDay>(builder: (_, day, wid) {
                                    return styleText(
                                        day.calorias != 0
                                            ? day.calorias.toStringAsFixed(2)
                                            : "0.00",
                                        18);
                                  }),
                                  Divider(),
                                  styleText("Alimento", 15)
                                ],
                              ),
                              Column(
                                children: [
                                  styleText("+", 20),
                                  Divider(),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  Consumer<RegisterDay>(builder: (_, day, wid) {
                                    return styleText(
                                        day.calEjercicio != 0
                                            ? day.calEjercicio
                                                .toStringAsFixed(2)
                                            : "0.00",
                                        18);
                                  }),
                                  Divider(),
                                  styleText("Ejercicio", 15)
                                ],
                              ),
                              Column(
                                children: [
                                  styleText("=", 20),
                                  Divider(),
                                  Divider()
                                ],
                              ),
                              Column(
                                children: [
                                  Consumer<Objetivos>(
                                      builder: (_, obj, __) =>
                                          Consumer<RegisterDay>(
                                            builder: (context, day, wid) =>
                                                styleText(
                                                    (obj.calDiarias -
                                                            day.calorias +
                                                            day.calEjercicio)
                                                        .toStringAsFixed(2),
                                                    18),
                                          )),
                                  Divider(),
                                  styleText("Restante", 15)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            preferredSize: Size.fromHeight(151.0),
          ),
        ),
        body: Consumer<RegisterParameters>(builder: (_, opt, wid) {
          db.dia = DateFormat("dd-MM-yyyy").format(opt.date);
          return StreamBuilder<RegisterDay>(
            stream: db.registerDay,
            builder: (_, snapshot) {
              var day = snapshot.data;
              if (day == null)
                day = RegisterDay(
                  desayuno: [],
                  almuerzo: [],
                  cena: [],
                  meriendas: [],
                  calorias: 0,
                  calEjercicio: 0,
                  ejercicio: [],
                );
              if (snapshot.connectionState == ConnectionState.waiting)
                return Loading();
              if (day != null)
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  styleText("Desayuno", 20),
                                  styleText(
                                      (day.desayuno == null)
                                          ? "0.00"
                                          : day.desayuno
                                              .fold(0,
                                                  (a, b) => a + b["calorias"])
                                              .toStringAsFixed(2),
                                      20)
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: day.desayuno != null
                                  ? day.desayuno.length
                                  : 0,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(width: 0.3)),
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  child: ListTile(
                                    trailing: Text(
                                      (day.desayuno[index]["raciones"] *
                                              day.desayuno[index]["racion"]
                                                  ["calorias"])
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    title: Text(day.desayuno[index]["nombre"]),
                                    subtitle: Text(
                                        "${day.desayuno[index]["descripción"]}, ${day.desayuno[index]["raciones"] * day.desayuno[index]["racion"]["tamaño"]} ${day.desayuno[index]["racion"]["medida"]}"),
                                  ),
                                  onPressed: () async {
                                    print("Hola");
                                    var alimento =
                                        await db.alimento(day.desayuno[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateFood(
                                          alimento: alimento,
                                        );
                                      }),
                                    );
                                    opt.nraciones = day.desayuno[index]
                                            ["raciones"]
                                        .toDouble();
                                    opt.racion = day.desayuno[index]["racion"];
                                    opt.option = "Desayuno";
                                    opt.index = index;
                                  },
                                  onLongPress: () {
                                    opt.option = "Desayuno";
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteDialog(index: index));
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey[350],
                              leading: Text("+"),
                              title: styleText("Añadir alimento", 15),
                              onTap: () {
                                option.option = "Desayuno";
                                page.page = "Alimentos";
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  styleText("Almuerzo", 20),
                                  styleText(
                                      (day.almuerzo == null)
                                          ? "0.00"
                                          : day.almuerzo
                                              .fold(0,
                                                  (a, b) => a + b["calorias"])
                                              .toStringAsFixed(2),
                                      20)
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: day.almuerzo != null
                                  ? day.almuerzo.length
                                  : 0,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(width: 0.3)),
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  child: ListTile(
                                    trailing: Text(
                                      (day.almuerzo[index]["raciones"] *
                                              day.almuerzo[index]["racion"]
                                                  ["calorias"])
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    title: Text(day.almuerzo[index]["nombre"]),
                                    subtitle: Text(
                                        "${day.almuerzo[index]["descripción"]}, ${day.almuerzo[index]["raciones"] * day.almuerzo[index]["racion"]["tamaño"]} ${day.almuerzo[index]["racion"]["medida"]}"),
                                  ),
                                  onPressed: () async {
                                    var alimento =
                                        await db.alimento(day.almuerzo[index]);
                                    print(alimento);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateFood(
                                          alimento: alimento,
                                        );
                                      }),
                                    );
                                    opt.nraciones = day.almuerzo[index]
                                            ["raciones"]
                                        .toDouble();
                                    opt.racion = day.almuerzo[index]["racion"];
                                    opt.option = "Almuerzo";
                                    opt.index = index;
                                  },
                                  onLongPress: () {
                                    opt.option = "Almuerzo";
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteDialog(index: index));
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey[350],
                              leading: Text("+"),
                              title: styleText("Añadir alimento", 15),
                              onTap: () {
                                option.option = "Almuerzo";
                                page.page = "Alimentos";
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  styleText("Cena", 20),
                                  styleText(
                                      (day.cena == null)
                                          ? "0.00"
                                          : day.cena
                                              .fold(0,
                                                  (a, b) => a + b["calorias"])
                                              .toStringAsFixed(2),
                                      20)
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: day.cena != null ? day.cena.length : 0,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(width: 0.3)),
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  child: ListTile(
                                    trailing: Text(
                                      (day.cena[index]["raciones"] *
                                              day.cena[index]["racion"]
                                                  ["calorias"])
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    title: Text(day.cena[index]["nombre"]),
                                    subtitle: Text(
                                        "${day.cena[index]["descripción"]}, ${day.cena[index]["raciones"] * day.cena[index]["racion"]["tamaño"]} ${day.cena[index]["racion"]["medida"]}"),
                                  ),
                                  onPressed: () async {
                                    var alimento =
                                        await db.alimento(day.cena[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateFood(
                                          alimento: alimento,
                                        );
                                      }),
                                    );
                                    opt.nraciones =
                                        day.cena[index]["raciones"].toDouble();
                                    opt.racion = day.cena[index]["racion"];
                                    opt.option = "Cena";
                                    opt.index = index;
                                  },
                                  onLongPress: () {
                                    opt.option = "Cena";
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteDialog(index: index));
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey[350],
                              leading: Text("+"),
                              title: styleText("Añadir alimento", 15),
                              onTap: () {
                                option.option = "Cena";
                                page.page = "Alimentos";
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  styleText("Meriendas", 20),
                                  styleText(
                                      (day.meriendas == null)
                                          ? "0.00"
                                          : day.meriendas
                                              .fold(0,
                                                  (a, b) => a + b["calorias"])
                                              .toStringAsFixed(2),
                                      20)
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: day.meriendas != null
                                  ? day.meriendas.length
                                  : 0,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(width: 0.3)),
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  child: ListTile(
                                    trailing: Text(
                                      (day.meriendas[index]["raciones"] *
                                              day.meriendas[index]["racion"]
                                                  ["calorias"])
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    title: Text(day.meriendas[index]["nombre"]),
                                    subtitle: Text(
                                        "${day.meriendas[index]["descripción"]}, ${day.meriendas[index]["raciones"] * day.meriendas[index]["racion"]["tamaño"]} ${day.meriendas[index]["racion"]["medida"]}"),
                                  ),
                                  onPressed: () async {
                                    var alimento =
                                        await db.alimento(day.meriendas[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateFood(
                                          alimento: alimento,
                                        );
                                      }),
                                    );
                                    opt.nraciones = day.meriendas[index]
                                            ["raciones"]
                                        .toDouble();
                                    opt.racion = day.meriendas[index]["racion"];
                                    opt.option = "Meriendas";
                                    opt.index = index;
                                  },
                                  onLongPress: () {
                                    opt.option = "Meriendas";
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteDialog(index: index));
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey[350],
                              leading: Text("+"),
                              title: styleText("Añadir alimento", 15),
                              onTap: () {
                                option.option = "Meriendas";
                                page.page = "Alimentos";
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  styleText("Ejercicio", 20),
                                  styleText(
                                      day.calEjercicio.toStringAsFixed(2), 20)
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: day.ejercicio != null
                                  ? day.ejercicio.length
                                  : 0,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide(width: 0.3)),
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  child: ListTile(
                                    trailing: Text(
                                      day.ejercicio[index]["calorias"]
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    title: Text(day.ejercicio[index]["nombre"]),
                                    subtitle: Text(
                                        "${day.ejercicio[index]["descripción"]}"),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return UpdateTraining(
                                          ejercicio: day.ejercicio[index],
                                        );
                                      }),
                                    );
                                    opt.index = index;
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteTraining(index: index));
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              tileColor: Colors.grey[350],
                              leading: Text("+"),
                              title: styleText("Añadir ejercicio", 15),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTraining()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              else
                return Loading();
            },
          );
        }),
      ),
    );
  }
}
