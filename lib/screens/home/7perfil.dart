import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';

import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/models/userData.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/services/storage.dart';
import 'package:healthyapp/widgets/styleText.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context, listen: false);
    final user = Provider.of<UserModel>(context);
    final storage = StorageService(uid: user.uid);
    final db = DatabaseService(uid: user.uid);
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Consumer<UserData>(
                      builder: (_, udata, wid) => Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child:
                                (udata.profileURL == "assets/images/perfil.jpg")
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          var url = await storage.uploadProfileImage();
                          await db.updateURL(url);
                        },
                      )),
                ]),
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
        onTap: (int index) {
          if (index == 0) page.page = "Home";
          if (index == 1) page.page = "Alimentos";
          if (index == 2) page.page = "Perfil";
        },
      ),
    );
  }
}
