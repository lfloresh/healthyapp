import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/models/registerDay.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/listDrawer.dart';
import 'package:healthyapp/widgets/loading.dart';
import 'package:healthyapp/widgets/popUpDialog.dart';
import 'package:healthyapp/widgets/styleText.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context, listen: false);
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    db.dia = DateFormat("dd-MM-yyyy").format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Healthy App"),
      ),
      drawer: listDrawer(context),
      body: FutureBuilder<RegisterDay>(
        future: db.day(),
        builder: (_, day) {
          if (day.connectionState == ConnectionState.waiting ||
              day.connectionState == ConnectionState.none) return Loading();
          if (day.hasData)
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Resumen calórico del día",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton(
                            iconSize: 20,
                            splashRadius: 10,
                            icon: Icon(Icons.help_rounded),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => buildPopUpDialog(context),
                              );
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        styleText("Calorías Objetivo", 20),
                        Consumer<Objetivos>(builder: (_, obj, __) {
                          return styleText(
                              obj.calDiarias.toStringAsFixed(0), 20);
                        })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        styleText("Calorías Alimento", 20),
                        styleText(day.data.calorias.toStringAsFixed(2), 20),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        styleText("Calorías Ejercicio", 20),
                        styleText(day.data.calEjercicio.toStringAsFixed(2), 20)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        styleText("Calorías Restantes", 20),
                        Consumer<Objetivos>(
                            builder: (_, obj, __) => styleText(
                                (obj.calDiarias -
                                        day.data.calorias +
                                        day.data.calEjercicio)
                                    .toStringAsFixed(2),
                                20))
                      ],
                    ),
                  ],
                ),
              ),
            );
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resumen calórico del día",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          iconSize: 20,
                          splashRadius: 10,
                          icon: Icon(Icons.help_rounded),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => buildPopUpDialog(context),
                            );
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      styleText("Calorías Objetivo", 20),
                      Consumer<Objetivos>(
                          builder: (_, obj, __) =>
                              styleText(obj.calDiarias.toStringAsFixed(0), 20))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      styleText("Calorías Alimento", 20),
                      styleText("0", 20),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      styleText("Calorías Ejercicio", 20),
                      styleText("0", 20)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      styleText("Calorías Restantes", 20),
                      Consumer<Objetivos>(
                          builder: (_, obj, __) => styleText(
                              (obj.calDiarias).toStringAsFixed(0), 20))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Alimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (int index) {
          if (index == 0) page.page = "Home";
          if (index == 1) page.page = "Alimentos";
          if (index == 2) page.page = "Perfil";
        },
      ),
    );
  }
}
