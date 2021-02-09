import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testAndroid/models/homeData.dart';
import 'package:testAndroid/models/user.dart';
import 'package:testAndroid/screens/Authenticate/authenticate.dart';
import 'package:testAndroid/screens/switch.dart';
import 'package:testAndroid/services/database.dart';

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
          StreamProvider<HomeData>.value(
              value: DatabaseService(uid: user.uid).homeData),
        ],
        child: SwitchPage(),
      );
    }
  }
}
