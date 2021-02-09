import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthyapp/services/auth.dart';
import 'package:healthyapp/widgets/loading.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                              validator: (val) =>
                                  val.isEmpty ? 'Ingresar un E-mail' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.black,
                                ),
                                hintText: 'Contraseña',
                              ),
                              validator: (val) => val.length < 6
                                  ? 'Ingresar una contraseña +6 caracteres'
                                  : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                child: Text("Ingresar"),
                                color: Colors.green[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.loginWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'E-mail o contraseña inválidos';
                                      });
                                    }
                                  }
                                },
                              ),
                              RaisedButton(
                                child: Text("Registrar"),
                                color: Colors.green[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () => widget.toggleView(),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
