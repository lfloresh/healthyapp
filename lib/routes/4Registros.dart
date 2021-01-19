import 'package:flutter/material.dart';
import 'package:healthyapp/other/shortcuts.dart';

class RegistrosPage extends StatefulWidget {
  RegistrosPage({Key key}) : super(key: key);

  @override
  _RegistrosPageState createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registros"),
        backgroundColor: Color(0xff417505),
      ),
      drawer: listDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    styleText("Calorías restantes", 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            styleText("1,670", 20),
                            Divider(),
                            styleText("Objetivo", 15)
                          ],
                        ),
                        Column(
                          children: [styleText("-", 20), Divider(), Divider()],
                        ),
                        Column(
                          children: [
                            styleText("0", 20),
                            Divider(),
                            styleText("Alimento", 15)
                          ],
                        ),
                        Column(
                          children: [styleText("+", 20), Divider(), Divider()],
                        ),
                        Column(
                          children: [
                            styleText("0", 20),
                            Divider(),
                            styleText("Ejercicio", 15)
                          ],
                        ),
                        Column(
                          children: [styleText("=", 20), Divider(), Divider()],
                        ),
                        Column(
                          children: [
                            styleText("1,670", 20),
                            Divider(),
                            styleText("Restante", 15)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [styleText("Desayuno", 20), styleText("0", 20)],
                    ),
                  ),
                  ListTile(
                    tileColor: Colors.grey[350],
                    leading: Text("+"),
                    title: styleText("Añadir alimento", 15),
                    onTap: () => Navigator.pushNamed(context, '/Alimentos'),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [styleText("Almuerzo", 20), styleText("0", 20)],
                    ),
                  ),
                  ListTile(
                    tileColor: Colors.grey[350],
                    leading: Text("+"),
                    title: styleText("Añadir alimento", 15),
                    onTap: () => Navigator.pushNamed(context, '/Alimentos'),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [styleText("Cena", 20), styleText("0", 20)],
                    ),
                  ),
                  ListTile(
                    tileColor: Colors.grey[350],
                    leading: Text("+"),
                    title: styleText("Añadir alimento", 15),
                    onTap: () => Navigator.pushNamed(context, '/Alimentos'),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        styleText("Meriendas", 20),
                        styleText("0", 20)
                      ],
                    ),
                  ),
                  ListTile(
                    tileColor: Colors.grey[350],
                    leading: Text("+"),
                    title: styleText("Añadir alimento", 15),
                    onTap: () => Navigator.pushNamed(context, '/Alimentos'),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              styleText("Ejercicio", 20),
                              styleText("0", 20)
                            ],
                          ),
                        ),
                        ListTile(
                          tileColor: Colors.grey[350],
                          leading: Text("+"),
                          title: styleText("Añadir ejercicio", 15),
                          onTap: () =>
                              Navigator.pushNamed(context, '/Alimentos'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   height: 100,
            //   width: MediaQuery.of(context).size.width,
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10)),
            //     elevation: 10,
            //     child: Text("hola"),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
