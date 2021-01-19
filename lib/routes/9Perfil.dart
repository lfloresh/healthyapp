import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  void _goToPage(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/Home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/Alimentos');
    if (index == 2) Navigator.pushReplacementNamed(context, '/Perfil');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/images/perfil.jpg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Luis Angel",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xff417505),
            ),
          ),
          Container(
            child: Image.asset("assets/images/progreso.jpg"),
          ),
          Card(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    alignment: Alignment.centerLeft,
                    child: styleText("Objetivos", 20)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      styleText("Peso", 15),
                      styleText("60 kg", 20),
                      styleText("Perder 0.5 kg por semana", 15)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      styleText("Calorías diarias", 15),
                      styleText("1,670 cal", 20),
                      styleText(
                          "Carbohidratos 209g / Grasas 56g / Proteínas 84g", 15)
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        currentIndex: 2,
        onTap: _goToPage,
      ),
    );
  }
}
