import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff417505),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment(0, 0),
              height: 300,
              child: Image.asset("assets/images/logo.png"),
            ),
            Container(
              width: 310,
              padding: EdgeInsets.only(
                top: 4,
                left: 16,
                right: 16,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: 'E-mail',
                ),
              ),
            ),
            Divider(),
            Container(
              width: 310,
              padding: EdgeInsets.only(
                top: 4,
                left: 16,
                right: 16,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                  ),
                  hintText: 'Contraseña',
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: new Text("Ingresar"),
                  color: Colors.green[300],
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/Home', (_) => false);
                    //login();
                    //Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: new Text("Registrar"),
                  color: Colors.green[300],
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Register');
                    //login();
                    //Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
