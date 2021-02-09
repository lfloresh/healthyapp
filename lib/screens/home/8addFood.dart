import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/alimento.dart';
import 'package:healthyapp/models/macros.dart';
import 'package:healthyapp/models/user.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/partOfTheDay.dart';
import 'package:healthyapp/widgets/racionesDialog.dart';
import 'package:healthyapp/widgets/styleText.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AddFood extends StatefulWidget {
  final Alimento alimento;
  final double raciones;
  final Map racion;
  AddFood({Key key, this.alimento, this.racion, this.raciones})
      : super(key: key);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  List<charts.Series<Macro, String>> _seriesPieData;

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context, listen: false);
    final option = Provider.of<RegisterParameters>(context, listen: false);
    final user = Provider.of<UserModel>(context, listen: false);
    final db = DatabaseService(uid: user.uid);
    _seriesPieData = List<charts.Series<Macro, String>>();
    var pieData = [
      Macro(
        color: Colors.blue,
        macro: "carbohidratos",
        value: widget.alimento.carbohidratos,
      ),
      Macro(
        color: Colors.red,
        macro: "grasas",
        value: widget.alimento.grasas,
      ),
      Macro(
        color: Colors.green,
        macro: "proteínas",
        value: widget.alimento.proteinas,
      ),
    ];
    _seriesPieData.add(
      charts.Series(
        domainFn: (Macro macro, _) => macro.macro,
        measureFn: (Macro macro, _) => macro.value,
        colorFn: (Macro macro, _) =>
            charts.ColorUtil.fromDartColor(macro.color),
        id: '%Macros',
        data: pieData,
        //labelAccessorFn: (Macro row, _) => '${row.value}',
      ),
    );
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Consumer<RegisterParameters>(
            builder: (_, opt, widget) =>
                (Text("Añadir alimento (${opt.option})"))),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => partOfTheDay(context),
              ),
              child: styleText("Hora", 15),
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
        children: <Widget>[
          Container(
            height: 80,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.3)),
              color: Colors.white,
            ),
            child: styleText(
                "${widget.alimento.nombre}\n(${widget.alimento.description})",
                20),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.3)),
              color: Colors.white,
            ),
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Número de raciones",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Consumer<RegisterParameters>(
                    builder: (_, opt, wid) => Text(
                      opt.nraciones.toString(),
                      style: TextStyle(fontSize: 18, color: Color(0xff417505)),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RacionesDialog(
                    alimento: widget.alimento,
                    context: context,
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.3)),
              color: Colors.white,
            ),
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tamaño de la ración",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Consumer<RegisterParameters>(
                    builder: (_, opt, wid) => Text(
                      "${opt.racion["tamaño"].toDouble()} ${opt.racion["medida"]}",
                      style: TextStyle(fontSize: 18, color: Color(0xff417505)),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RacionesDialog(
                    alimento: widget.alimento,
                    context: context,
                  ),
                );
              },
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.37)),
              color: Colors.white,
            ),
            child: Stack(
              children: <Widget>[
                charts.PieChart(
                  _seriesPieData,
                  animate: false,
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 10,
                  ),
                ),
                Consumer<RegisterParameters>(
                  builder: (_, opt, wid) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styleText(
                            (opt.nraciones * opt.racion["calorias"])
                                .toStringAsFixed(2),
                            20),
                        styleText("Calorías", 20)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.3)),
              color: Colors.white,
            ),
            child: Consumer<RegisterParameters>(
              builder: (_, opt, wid) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styleText("${widget.alimento.carbohidratos}%", 15),
                        Text(
                          (opt.nraciones *
                                      opt.racion["macros"] *
                                      widget.alimento.carbohidratos /
                                      100)
                                  .toStringAsFixed(2) +
                              "${opt.racion["medida"]}",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        Text(
                          "Carbohidratos",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styleText("${widget.alimento.grasas}%", 15),
                        Text(
                          (opt.nraciones *
                                      opt.racion["macros"] *
                                      widget.alimento.grasas /
                                      100)
                                  .toStringAsFixed(2) +
                              "${opt.racion["medida"]}",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        Text(
                          "Grasas",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styleText("${widget.alimento.proteinas}%", 15),
                        Text(
                          (opt.nraciones *
                                      opt.racion["macros"] *
                                      widget.alimento.proteinas /
                                      100)
                                  .toStringAsFixed(2) +
                              "${opt.racion["medida"]}",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        Text(
                          "Proteínas",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 150),
            child: FlatButton(
              color: Color(0xff417505),
              child: Text(
                "Añadir",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () async {
                await db.registerAlimento(option, widget.alimento);
                Navigator.pop(context);
                page.page = "Registros";
              },
            ),
          )
        ],
      ),
    );
  }
}
