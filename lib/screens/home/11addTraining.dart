import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/styleText.dart';
import 'package:intl/intl.dart';

class AddTraining extends StatefulWidget {
  AddTraining({Key key}) : super(key: key);

  @override
  _AddTrainingState createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  final _formKey = GlobalKey<FormState>();

  String nombre;
  String descripcion;
  double calorias;
  Map ejercicio;
  @override
  Widget build(BuildContext context) {
    final option = Provider.of<RegisterParameters>(context, listen: false);
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Añadir ejercicio"),
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
                  ejercicio = {
                    "nombre": nombre,
                    "descripción": descripcion,
                    "calorias": calorias
                  };
                  await db.addTraining(option, ejercicio);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(51.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]),
              ),
              color: Colors.white,
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: FlatButton(
                    onPressed: () {
                      option.date = DateTime(option.date.year,
                          option.date.month, option.date.day - 1);
                    },
                    child: Icon(
                      Icons.arrow_left,
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: FlatButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        locale: const Locale("es", "ES"),
                        currentDate: DateTime.now(),
                        initialDate: option.date,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Color(0xff417505),
                                onPrimary: Colors.white,
                                surface: Color(0xff417505),
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor: Colors.green,
                            ),
                            child: child,
                          );
                        },
                      ).then((date) {
                        if (date != null) option.date = date;
                      });
                    },
                    child: Consumer<RegisterParameters>(
                      builder: (_, date, widget) => DateFormat("dd-MM-yyyy")
                                  .format(DateTime.now()) ==
                              DateFormat("dd-MM-yyyy").format(date.date)
                          ? styleText("Hoy", 20)
                          : styleText(
                              DateFormat.yMMMd("es_PE").format(date.date), 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: FlatButton(
                    onPressed: () {
                      option.date = DateTime(option.date.year,
                          option.date.month, option.date.day + 1);
                    },
                    child: Icon(
                      Icons.arrow_right,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                      decoration: InputDecoration(
                        hintText: "Correr",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Ingrese un nombre" : null,
                      onChanged: (val) => setState(() => nombre = val),
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
                      decoration: InputDecoration(
                        hintText: "Trotar 15 min a 7.5 min/km",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Ingrese una descripción" : null,
                      onChanged: (val) => setState(() => descripcion = val),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "100",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Ingrese la calorias quemadas" : null,
                      onChanged: (val) =>
                          setState(() => calorias = double.parse(val)),
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
