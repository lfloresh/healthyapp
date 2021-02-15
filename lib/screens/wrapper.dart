import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/models/userData.dart';
import 'package:healthyapp/screens/Authenticate/authenticate.dart';
import 'package:healthyapp/screens/switch.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/services/storage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return MultiProvider(
        providers: [
          StreamProvider<String>.value(
            value: StorageService(uid: user.uid).profileImage,
            initialData: "assets/images/perfil.jpg",
            catchError: (_, __) => "assets/images/perfil.jpg",
          ),
          StreamProvider<Objetivos>.value(
              initialData: Objetivos(
                  calDiarias: 0.0,
                  carDiarias: 0.0,
                  graDiarias: 0.0,
                  pActual: 0.0,
                  pDeseado: 0.0,
                  pInicial: 0.0,
                  proDiarias: 0.0),
              catchError: (_, __) => Objetivos(
                  calDiarias: 0.0,
                  carDiarias: 0.0,
                  graDiarias: 0.0,
                  pActual: 0.0,
                  pDeseado: 0.0,
                  pInicial: 0.0,
                  proDiarias: 0.0),
              value: DatabaseService(uid: user.uid).objetivos),
          StreamProvider<UserData>.value(
            value: DatabaseService(uid: user.uid).userData,
            initialData:
                UserData(username: "", profileURL: "assets/images/perfil.jpg"),
            catchError: (_, __) =>
                UserData(username: "", profileURL: "assets/images/perfil.jpg"),
          ),
        ],
        child: SwitchPage(),
      );
    }
  }
}
