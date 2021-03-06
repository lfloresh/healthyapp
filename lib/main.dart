import 'package:flutter/material.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/screens/wrapper.dart';
import 'package:healthyapp/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PruebasApp());
}

class PruebasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentPage>(create: (_) => CurrentPage()),
        StreamProvider<UserModel>.value(value: AuthService().user),
        ChangeNotifierProvider<RegisterParameters>(
            create: (_) => RegisterParameters()),
      ],
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('en'), const Locale('es')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: Colors.green,
            appBarTheme: AppBarTheme(color: Color(0xff417505))),
        title: "Pruebas",
        home: Wrapper(),
      ),
    );
  }
}
