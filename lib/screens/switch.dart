import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/screens/home/1home.dart';
import 'package:healthyapp/screens/home/2registros.dart';
import 'package:healthyapp/screens/home/3progreso.dart';
import 'package:healthyapp/screens/home/4objetivos.dart';
import 'package:healthyapp/screens/home/6alimentos.dart';
import 'package:healthyapp/screens/home/7perfil.dart';
import 'package:healthyapp/services/database.dart';

class SwitchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context);
    final user = Provider.of<UserModel>(context);
    final db = DatabaseService(uid: user.uid);
    print(page.page);
    switch (page.page) {
      case "Home":
        return HomePage();
      case "Registros":
        return RegistrosPage();
      case "Progreso":
        return ProgresoPage();
      case "Objetivos":
        return ObjetivosPage();
      case "Alimentos":
        return AlimentosPage(
          db: db,
        );
      case "Perfil":
        return PerfilPage();
    }
    return null;
  }
}
