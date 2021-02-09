import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testAndroid/Notifiers/registerParameters.dart';
import 'package:testAndroid/models/alimento.dart';
import 'package:testAndroid/models/homeData.dart';
import 'package:testAndroid/models/registerDay.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  String name = "";

  DatabaseService({this.uid});
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  HomeData _homeFromFirebaseHome(DocumentSnapshot doc) {
    return doc != null
        ? HomeData(
            calObjetivo: doc.data()["calObjetivo"],
            calAlimento: doc.data()["calAlimento"],
            calEjercicio: doc.data()["calEjercicio"],
            calRestante: doc.data()["calRestante"],
          )
        : null;
  }

  RegisterDay _registerDayFromFirebase(DocumentSnapshot doc) {
    return doc != null
        ? RegisterDay(
            desayuno: doc.data()["desayuno"],
            almuerzo: doc.data()["almuerzo"],
            cena: doc.data()["cena"],
            meriendas: doc.data()["meriendas"],
            fecha: doc.data()["fecha"],
          )
        : null;
  }

  List<Alimento> _alimentosFromFirebase(QuerySnapshot snapshots) {
    return snapshots != null
        ? snapshots.docs
            .map((alimento) => Alimento(
                id: alimento.data()["id"],
                nombre: alimento.data()["nombre"],
                description: alimento.data()["descripción"],
                carbohidratos: alimento.data()["%carbohidratos"].toDouble(),
                grasas: alimento.data()["%grasas"].toDouble(),
                proteinas: alimento.data()["%proteínas"].toDouble(),
                raciones: alimento.data()["raciones"]))
            .toList()
        : null;
  }

  Alimento _alimentoFromFirebase(DocumentSnapshot doc) {
    return doc != null
        ? Alimento(
            id: doc.data()["id"],
            nombre: doc.data()["nombre"],
            description: doc.data()["descripción"],
            carbohidratos: doc.data()["%carbohidratos"].toDouble(),
            grasas: doc.data()["%grasas"].toDouble(),
            proteinas: doc.data()["%proteínas"].toDouble(),
            raciones: doc.data()["raciones"])
        : null;
  }

  Stream<HomeData> get homeData {
    return _db
        .collection("homeData")
        .doc(uid)
        .snapshots()
        .map(_homeFromFirebaseHome);
  }

  Stream<List<Alimento>> get alimentos {
    return _db
        .collection("Alimentos")
        .where("searchKeywords", arrayContains: name)
        .snapshots()
        .map(_alimentosFromFirebase);
  }

  Future<void> registerData(String username) async {
    return await _db.collection("users").doc(uid).set({"username": username});
  }

  Future<HomeData> getHomeData() async {
    try {
      return await _db
          .collection("homeData")
          .doc(uid)
          .get()
          .then((doc) => _homeFromFirebaseHome(doc));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<RegisterDay> registerDay(String dia) async {
    try {
      return await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(dia)
          .get()
          .then((doc) => _registerDayFromFirebase(doc));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<Alimento> alimento(String id) async {
    try {
      return await _db
          .collection("Alimentos")
          .doc(id)
          .get()
          .then((doc) => _alimentoFromFirebase(doc));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future registerAlimento(RegisterParameters opt, Alimento alimento) async {
    try {
      return await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(DateFormat("dd-MM-yyyy").format(opt.date)) //fecha
          .get()
          .then((doc) async {
        if (doc.data() == null) {
          List<Map> list = [];
          Map racion = opt.racion;
          Map food = {
            "alimento": alimento.id,
            "descripción": alimento.description,
            "nombre": alimento.nombre,
            "racion": racion,
            "raciones": opt.nraciones,
          };
          list.add(food);
          Map<String, dynamic> dia = {
            opt.option.toLowerCase(): list,
            "calorias": opt.nraciones * opt.racion["calorias"],
            "fecha": DateFormat("dd-MM-yyyy").format(opt.date),
          };
          await _db
              .collection("registros")
              .doc(uid)
              .collection("dias")
              .doc(DateFormat("dd-MM-yyyy").format(opt.date))
              .set(HashMap.from(dia));
        } else {
          List<dynamic> list;
          if (doc.data()[opt.option.toLowerCase()] == null)
            list = [];
          else
            list = doc.data()[opt.option.toLowerCase()];
          Map racion = opt.racion;
          Map food = {
            "alimento": alimento.id,
            "descripción": alimento.description,
            "nombre": alimento.nombre,
            "racion": racion,
            "raciones": opt.nraciones,
          };
          list.add(food);
          double calorias = doc.data()["calorias"];
          calorias = calorias + opt.nraciones * opt.racion["calorias"];
          await _db
              .collection("registros")
              .doc(uid)
              .collection("dias")
              .doc(DateFormat("dd-MM-yyyy").format(opt.date))
              .update({opt.option.toLowerCase(): list, "calorias": calorias});
        }
      });
    } catch (error) {
      print(error);
    }
  }
}
