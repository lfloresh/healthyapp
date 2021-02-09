import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testAndroid/Notifiers/currentPage.dart';
import 'package:testAndroid/screens/home/1home.dart';
import 'package:testAndroid/screens/home/2registros.dart';
import 'package:testAndroid/screens/home/3progreso.dart';
import 'package:testAndroid/screens/home/4objetivos.dart';
import 'package:testAndroid/screens/home/5graficos.dart';
import 'package:testAndroid/screens/home/6alimentos.dart';
import 'package:testAndroid/screens/home/7perfil.dart';

class SwitchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context);
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
      case "Gráficos":
        return GraficosPage();
      case "Alimentos":
        return AlimentosPage();
      case "Perfil":
        return PerfilPage();
    }
    return null;
  }
}
