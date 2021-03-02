import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/styleText.dart';
import 'package:intl/intl.dart';

class AddEntrada extends StatefulWidget {
  final Objetivos objetivos;
  AddEntrada({Key key, this.objetivos}) : super(key: key);

  @override
  _AddEntradaState createState() => _AddEntradaState();
}

class _AddEntradaState extends State<AddEntrada> {
  final _formKey = GlobalKey<FormState>();
  double peso;
  String date;
  String menorFecha;
  @override
  void initState() {
    super.initState();
    peso = 0;
    date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    menorFecha = widget.objetivos.menorFecha;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: styleText("Añadir entrada", 20),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: styleText("Añadir", 20),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  Map objetivos = {
                    "pInicial": widget.objetivos.pInicial,
                    "pActual": widget.objetivos.pActual,
                    "pDeseado": widget.objetivos.pDeseado,
                    "calDiarias": widget.objetivos.calDiarias,
                    "carDiarias": widget.objetivos.carDiarias,
                    "proDiarias": widget.objetivos.proDiarias,
                    "graDiarias": widget.objetivos.graDiarias,
                    "date": widget.objetivos.date,
                    "menorFecha": menorFecha,
                  };
                  await db.setObjectives(objetivos);
                  Map entradaI = {
                    "peso": peso == null ? 0 : peso,
                    "fecha": date == null
                        ? DateFormat("yyyy-MM-dd").format(DateTime.now())
                        : date.split('-').reversed.join('-')
                  };
                  await db.setEntrada(entradaI);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green[200],
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            margin: EdgeInsets.only(top: 15, right: 5, left: 5),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: Color(0xff417505),
                  child: Text("Entrada",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Peso (kg)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Container(
                        width: MediaQuery.of(context).size.width * 1 / 5,
                        child: TextFormField(
                          initialValue: "0",
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "Requerido",
                          ),
                          validator: (val) => val.isEmpty ? "Requerido" : null,
                          onChanged: (val) =>
                              setState(() => peso = double.parse(val)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fecha",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Container(
                        width: 100,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          child: styleText(date, 15),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              locale: const Locale("es", "ES"),
                              currentDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime.now(),
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
                            ).then((dateSelected) {
                              if (dateSelected != null)
                                setState(() {
                                  date = DateFormat("dd-MM-yyyy")
                                      .format(dateSelected);
                                  if (DateTime.parse(widget.objetivos.menorFecha
                                              .split('-')
                                              .reversed
                                              .join())
                                          .compareTo(dateSelected) >
                                      0) menorFecha = date;
                                });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
