import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class AlimentosPage extends StatefulWidget {
  AlimentosPage({Key key}) : super(key: key);

  @override
  _AlimentosPageState createState() => _AlimentosPageState();
}

class _AlimentosPageState extends State<AlimentosPage> {
  void _goToPage(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/Home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/Alimentos');
    if (index == 2) Navigator.pushReplacementNamed(context, '/Perfil');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alimentos"),
        backgroundColor: Color(0xff417505),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                print("Crear alimento");
              },
              child: styleText("+", 25),
            ),
          ),
        ],
      ),
      drawer: listDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 60, left: 15, top: 15, bottom: 15),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey[300],
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Busca un alimento',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.centerLeft,
              child: styleText("Historial", 20),
            ),
            Container(
              child: ListTile(
                title: styleText("Quinoa perlada", 15),
                subtitle: styleText("Inca sur, 15 g", 15),
                trailing: styleText("47", 15),
                onTap: () => {},
              ),
            ),
            Container(
              child: ListTile(
                title: styleText("Brócoli", 15),
                subtitle: styleText("Brócoli, 250 g", 15),
                trailing: styleText("98", 15),
                onTap: () => {},
              ),
            ),
            Container(
              child: ListTile(
                title: styleText("Pan Integral", 15),
                subtitle: styleText("Petipan, 44 g, 2 unidades", 15),
                trailing: styleText("150", 15),
                onTap: () => {},
              ),
            ),
            Container(
              child: ListTile(
                title: styleText("Cebolla", 15),
                subtitle: styleText("Verdura, 120 g", 15),
                trailing: styleText("48", 15),
                onTap: () => {},
              ),
            ),
            Container(
              child: ListTile(
                title: styleText("Huevo Entero", 15),
                subtitle: styleText("Huevo, 1 pieza", 15),
                trailing: styleText("78", 15),
                onTap: () => {},
              ),
            ),
          ],
        ),
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
        currentIndex: 1,
        onTap: _goToPage,
      ),
    );
  }
}
