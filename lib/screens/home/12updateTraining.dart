import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';

class UpdateTraining extends StatefulWidget {
  final Map ejercicio;
  UpdateTraining({Key key, this.ejercicio}) : super(key: key);

  @override
  _UpdateTrainingState createState() => _UpdateTrainingState();
}

class _UpdateTrainingState extends State<UpdateTraining> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerNombre;
  TextEditingController _controllerDescripcion;
  TextEditingController _controllerCalorias;
  Map ejercico;
  @override
  void initState() {
    super.initState();
    _controllerNombre = TextEditingController(text: widget.ejercicio["nombre"]);
    _controllerDescripcion =
        TextEditingController(text: widget.ejercicio["descripción"]);
    _controllerCalorias = TextEditingController(
        text: widget.ejercicio["calorias"].toStringAsFixed(0));
  }

  @override
  Widget build(BuildContext context) {
    final option = Provider.of<RegisterParameters>(context, listen: false);
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Actualizar ejercicio"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Icon(
                Icons.check,
                size: 20,
              ),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  Map ejercicio = {
                    "nombre": _controllerNombre.text,
                    "descripción": _controllerDescripcion.text,
                    "calorias": double.parse(_controllerCalorias.text),
                  };
                  await db.updateTraining(option, ejercicio);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Form(
            key: _formKey,
            child: Card(
              margin: EdgeInsets.only(top: 15, right: 5, left: 5),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    color: Color(0xff417505),
                    child: Text("Ejercicio",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text("Nombre del ejercicio",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextFormField(
                      controller: _controllerNombre,
                      decoration: InputDecoration(
                        hintText: "Correr",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Ingrese un nombre" : null,
                      //onChanged: (val) => setState(() => nombre = val),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text("Descripción (obligatorio)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextFormField(
                      controller: _controllerDescripcion,
                      decoration: InputDecoration(
                        hintText: "Trotar 15 min a 7.5 min/km",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Ingrese una descripción" : null,
                      //onChanged: (val) => setState(() => descripcion = val),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text("Calorías quemadas",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextFormField(
                      controller: _controllerCalorias,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "100",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Ingrese la calorias quemadas" : null,
                      // onChanged: (val) =>
                      //     setState(() => calorias = double.parse(val)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
