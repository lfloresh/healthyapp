import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Widget intContainer(String text) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget intSizedBox(String text) {
    return SizedBox(
      height: 40.0,
      width: 320,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
        backgroundColor: Color(0xff417505),
      ),
      backgroundColor: Colors.green[300],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              intSizedBox("Crear un nombre de usuario"),
              intContainer("Nombre de usuario"),
              intSizedBox("E-mail"),
              intContainer("E-mail"),
              intSizedBox("Constraseña"),
              intContainer("Constraseña"),
              Divider(),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 130,
                ),
                color: Color(0xff417505),
                elevation: 10,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/Home', (_) => false),
                child: Text(
                  "Registrar",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
