import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToPage(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/Home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/Alimentos');
    if (index == 2) Navigator.pushReplacementNamed(context, '/Perfil');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healthy App"),
        backgroundColor: Color(0xff417505),
      ),
      drawer: listDrawer(context),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
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
                          styleText("1,670", 20),
                          Divider(),
                          styleText("Objetivo", 15)
                        ],
                      ),
                      Column(
                        children: [styleText("-", 20), Divider(), Divider()],
                      ),
                      Column(
                        children: [
                          styleText("0", 20),
                          Divider(),
                          styleText("Alimento", 15)
                        ],
                      ),
                      Column(
                        children: [styleText("+", 20), Divider(), Divider()],
                      ),
                      Column(
                        children: [
                          styleText("0", 20),
                          Divider(),
                          styleText("Ejercicio", 15)
                        ],
                      ),
                      Column(
                        children: [styleText("=", 20), Divider(), Divider()],
                      ),
                      Column(
                        children: [
                          styleText("1,670", 20),
                          Divider(),
                          styleText("Restante", 15)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 100,
          //   width: MediaQuery.of(context).size.width,
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10)),
          //     elevation: 10,
          //     child: Text("hola"),
          //   ),
          // )
        ],
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
        onTap: _goToPage,
      ),
    );
  }
}
