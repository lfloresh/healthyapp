import 'package:flutter/material.dart';
import 'package:healthyapp/routes/1Login.dart';
import 'package:healthyapp/routes/2Register.dart';
import 'package:healthyapp/routes/3Home.dart';
import 'package:healthyapp/routes/4Registros.dart';
import 'package:healthyapp/routes/5Progreso.dart';
import 'package:healthyapp/routes/6Objetivos.dart';
import 'package:healthyapp/routes/7Graficos.dart';
import 'package:healthyapp/routes/8Alimentos.dart';
import 'package:healthyapp/routes/9Perfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Healthy  App",
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => LoginPage(),
          '/Register': (BuildContext context) => RegisterPage(),
          '/Home': (BuildContext context) => HomePage(),
          '/Registros': (BuildContext context) => RegistrosPage(),
          '/Progreso': (BuildContext context) => ProgresoPage(),
          '/Objetivos': (BuildContext context) => ObjetivosPage(),
          '/Graficos': (BuildContext context) => GraficosPage(),
          '/Alimentos': (BuildContext context) => AlimentosPage(),
          '/Perfil': (BuildContext context) => PerfilPage(),
        });
  }
}
