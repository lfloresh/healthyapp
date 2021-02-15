import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/styleText.dart';

class CreateFood extends StatefulWidget {
  CreateFood({Key key}) : super(key: key);

  @override
  _CreateFoodState createState() => _CreateFoodState();
}

class _CreateFoodState extends State<CreateFood> {
  final _formKey = GlobalKey<FormState>();

  String nombre;
  String descripcion;
  double carbohidratos;
  double grasas;
  double proteinas;
  double tamano;
  String medida;
  double calorias;
  Map racion;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final db = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: styleText("Crear alimento", 20),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(
                Icons.check,
                size: 20,
              ),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  List keywords = [];
                  double macros = carbohidratos + proteinas + grasas;
                  nombre.toLowerCase().split("").fold("", (a, b) {
                    a = a + b;
                    keywords.add(a);
                    return a;
                  });
                  racion = {
                    "tamaño": tamano,
                    "calorias": calorias,
                    "medida": medida,
                    "macros": macros,
                  };
                  Map alimento = {
                    "%carbohidratos": double.parse(
                        (carbohidratos / macros * 100).toStringAsFixed(2)),
                    "%proteínas": double.parse(
                        (proteinas / macros * 100).toStringAsFixed(2)),
                    "%grasas": double.parse(
                        (grasas / macros * 100).toStringAsFixed(2)),
                    "nombre": nombre,
                    "general": false,
                    "descripción": descripcion,
                    "raciones": [racion],
                    "searchKeywords": keywords,
                  };
                  await db.createFood(alimento);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green[100],
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 15, right: 5, left: 5),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      color: Color(0xff417505),
                      child: Text("Nuevo alimento",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text("Nombre del alimento/marca (obligatorio)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Gloria",
                        ),
                        validator: (val) =>
                            val.isEmpty ? "Ingrese un nombre" : null,
                        onChanged: (val) => setState(() => nombre = val),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text("Descripción (obligatorio)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Leche descremada",
                        ),
                        validator: (val) =>
                            val.isEmpty ? "Ingrese una descripción" : null,
                        onChanged: (val) => setState(() => descripcion = val),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 15, right: 5, left: 5),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      color: Color(0xff417505),
                      child: Text("Ración",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text("Tamaño de la ración (obligatorio)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 2 / 5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: "1",
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Ingrese un número" : null,
                              onChanged: (val) =>
                                  setState(() => tamano = double.parse(val)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 2 / 5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "g/mL/etc",
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Medida requerida" : null,
                              onChanged: (val) => setState(() => medida = val),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 15, right: 5, left: 5),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      color: Color(0xff417505),
                      child: Text("Información nutriconal",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                    Container(
                      height: 70,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Calorias",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Container(
                            width: MediaQuery.of(context).size.width * 1 / 5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: "Requerido",
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Requerido" : null,
                              onChanged: (val) =>
                                  setState(() => calorias = double.parse(val)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Carbohidratos (g)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Container(
                            width: MediaQuery.of(context).size.width * 1 / 5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: "Requerido",
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Requerido" : null,
                              onChanged: (val) => setState(
                                  () => carbohidratos = double.parse(val)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Proteínas(g)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Container(
                            width: MediaQuery.of(context).size.width * 1 / 5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: "Requerido",
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Requerido" : null,
                              onChanged: (val) =>
                                  setState(() => proteinas = double.parse(val)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Grasas (g)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Container(
                            width: MediaQuery.of(context).size.width * 1 / 5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: "Requerido",
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Requerido" : null,
                              onChanged: (val) =>
                                  setState(() => grasas = double.parse(val)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
