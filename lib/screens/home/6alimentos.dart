import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthyapp/Notifiers/currentPage.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/alimento.dart';
import 'package:healthyapp/screens/home/8addFood.dart';
import 'package:healthyapp/services/database.dart';
import 'package:healthyapp/widgets/listDrawer.dart';
import 'package:healthyapp/widgets/styleText.dart';

class AlimentosPage extends StatefulWidget {
  AlimentosPage({Key key}) : super(key: key);
  @override
  _AlimentosPageState createState() => _AlimentosPageState();
}

class _AlimentosPageState extends State<AlimentosPage> {
  final _db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<CurrentPage>(context, listen: false);
    final option = Provider.of<RegisterParameters>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Alimentos"),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                print("Crear alimento");
              },
              child: styleText("+", 25),
            ),
          ),
        ],
      ),
      drawer: listDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 60, left: 15, top: 15, bottom: 15),
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey[300],
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Busca un alimento',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _db.name = value.toLowerCase().trim();
                  setState(() {});
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.centerLeft,
              child: styleText("Resultados", 20),
            ),
            StreamBuilder<List<Alimento>>(
              stream: _db.alimentos,
              builder: (context, snapshot) {
                if (_db.name == "") return Container();
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ))
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var a = snapshot.data[index];
                          var racion = a.raciones[0];
                          return Container(
                            child: ListTile(
                              title: styleText(a.nombre, 15),
                              subtitle: styleText(
                                  "${a.description}, ${racion["tamaño"].toDouble()} ${racion["medida"]} ",
                                  15),
                              trailing: styleText("${racion["calorias"]}", 15),
                              onTap: () {
                                option.racion = racion;
                                option.nraciones = 1.0;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFood(
                                      alimento: snapshot.data[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Alimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) page.page = "Home";
          if (index == 1) page.page = "Alimentos";
          if (index == 2) page.page = "Perfil";
        },
      ),
    );
  }
}
