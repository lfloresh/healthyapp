import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/models/userData.dart';
import 'package:healthyapp/services/auth.dart';

Widget listDrawer(BuildContext context) {
  final page = Provider.of<CurrentPage>(context, listen: false);
  final AuthService _auth = AuthService();
  return Container(
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Consumer<UserData>(
              builder: (_, udata, wid) => Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: (udata.profileURL == "assets/images/perfil.jpg")
                        ? Image.asset(
                            udata.profileURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            udata.profileURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      udata.username,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff417505),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Home";
            },
          ),
          ListTile(
            leading: Icon(Icons.folder_open),
            title: Text('Registros', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Registros";
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Progreso', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Progreso";
            },
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text('Objetivos', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Objetivos";
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank_outlined),
            title: Text('Alimentos', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Alimentos";
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Perfil";
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel_outlined),
            title: Text('Cerrar Sesión', style: TextStyle(fontSize: 20)),
            onTap: () async {
              await _auth.signOut();
              page.page = "Home";
            },
          ),
        ],
      ),
    ),
  );
}
