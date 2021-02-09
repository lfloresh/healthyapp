import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testAndroid/Notifiers/currentPage.dart';
import 'package:testAndroid/models/homeData.dart';
import 'package:testAndroid/widgets/listDrawer.dart';
import 'package:testAndroid/widgets/loading.dart';
import 'package:testAndroid/widgets/popUpDialog.dart';
import 'package:testAndroid/widgets/styleText.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Healthy App"),
      ),
      drawer: listDrawer(context),
      body: Consumer<HomeData>(
        builder: (context, homeData, _) {
          return homeData != null
              ? Card(
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
                                    builder: (context) =>
                                        buildPopUpDialog(context),
                                  );
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            styleText("Calorías Objetivo", 20),
                            styleText(homeData.calObjetivo, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            styleText("Calorías Alimento", 20),
                            styleText(homeData.calAlimento, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            styleText("Calorías Ejercicio", 20),
                            styleText(homeData.calEjercicio, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            styleText("Calorías Restantes", 20),
                            styleText(homeData.calRestante, 20)
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Loading();
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
