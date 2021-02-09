import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/models/homeData.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/screens/Authenticate/authenticate.dart';
import 'package:healthyapp/screens/switch.dart';
import 'package:healthyapp/services/database.dart';

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
