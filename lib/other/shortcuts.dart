import 'package:flutter/material.dart';

Widget listDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
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
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Home');
          },
        ),
        ListTile(
          leading: Icon(Icons.folder_open),
          title: Text('Registros', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Registros');
          },
        ),
        ListTile(
          leading: Icon(Icons.bar_chart),
          title: Text('Progreso', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Progreso');
          },
        ),
        ListTile(
          leading: Icon(Icons.check_circle_outline),
          title: Text('Objetivos', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Objetivos');
          },
        ),
        ListTile(
          leading: Icon(Icons.insert_chart_outlined),
          title: Text('Gráficos', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Graficos');
          },
        ),
        ListTile(
          leading: Icon(Icons.food_bank_outlined),
          title: Text('Alimentos', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Alimentos');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Perfil', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Perfil');
          },
        ),
        ListTile(
          leading: Icon(Icons.cancel_outlined),
          title: Text('Cerrar Sesión', style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    ),
  );
}

Widget styleText(String text, double font) {
  return Text(text, style: TextStyle(fontSize: font));
}
