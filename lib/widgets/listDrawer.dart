import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/auth.dart';
import 'package:healthyapp/services/storage.dart';

Widget listDrawer(BuildContext context) {
  final page = Provider.of<CurrentPage>(context, listen: false);
  final user = Provider.of<UserModel>(context);
  final AuthService _auth = AuthService();
  final StorageService _storage = StorageService(uid: user.uid);
  return Container(
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: FutureBuilder(
                      future: _storage.getProfileImage(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.network(
                            snapshot.data,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          );
                        } else {
                          return Image.asset(
                            "assets/images/perfil.jpg",
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          );
                        }
                      },
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
            leading: Icon(Icons.insert_chart_outlined),
            title: Text('Gráficos', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              page.page = "Gráficos";
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
            },
          ),
        ],
      ),
    ),
  );
}
