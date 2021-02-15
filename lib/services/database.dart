import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthyapp/Notifiers/registerParameters.dart';
import 'package:healthyapp/models/alimento.dart';
import 'package:healthyapp/models/objetivos.dart';
import 'package:healthyapp/models/registerDay.dart';
import 'package:intl/intl.dart';
import 'package:healthyapp/models/userData.dart';

class DatabaseService {
  String uid;
  String _dia;
  String name = "";

  DatabaseService({this.uid});
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  set dia(String value) => _dia = value;
  set userid(String value) => uid = value;

  UserData _userDataFromFirebase(DocumentSnapshot doc) {
    return doc.exists
        ? UserData(
            username: doc.data()["username"],
            profileURL: doc.data()["profileURL"] ?? "assets/images/perfil.jpg")
        : null;
  }

  RegisterDay _registerDayFromFirebase(DocumentSnapshot doc) {
    return doc != null
        ? RegisterDay(
            desayuno: doc.data()["desayuno"],
            almuerzo: doc.data()["almuerzo"],
            cena: doc.data()["cena"],
            meriendas: doc.data()["meriendas"],
            ejercicio: doc.data()["ejercicio"],
            fecha: doc.data()["fecha"],
            calorias:
                doc.data()["calorias"] == 0 ? 0.0 : doc.data()["calorias"],
            calEjercicio: doc.data()["calEjercicio"] == 0
                ? 0.0
                : doc.data()["calEjercicio"],
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
                general: alimento.data()["general"],
                carbohidratos: alimento.data()["%carbohidratos"].toDouble(),
                grasas: alimento.data()["%grasas"].toDouble(),
                proteinas: alimento.data()["%proteínas"].toDouble(),
                raciones: alimento.data()["raciones"]))
            .toList()
        : null;
  }

  Alimento _alimentoFromFirebase(DocumentSnapshot doc) {
    return doc.exists
        ? Alimento(
            id: doc.data()["id"],
            nombre: doc.data()["nombre"],
            description: doc.data()["descripción"],
            general: doc.data()["general"],
            carbohidratos: doc.data()["%carbohidratos"].toDouble(),
            grasas: doc.data()["%grasas"].toDouble(),
            proteinas: doc.data()["%proteínas"].toDouble(),
            raciones: doc.data()["raciones"])
        : null;
  }

  Objetivos _objetivosFromFirebase(DocumentSnapshot doc) {
    return doc != null
        ? Objetivos(
            pInicial: doc.data()["pInicial"].toDouble(),
            pActual: doc.data()["pActual"].toDouble(),
            pDeseado: doc.data()["pDeseado"].toDouble(),
            calDiarias: doc.data()["calDiarias"].toDouble(),
            carDiarias: doc.data()["carDiarias"].toDouble(),
            proDiarias: doc.data()["proDiarias"].toDouble(),
            graDiarias: doc.data()["graDiarias"].toDouble())
        : null;
  }

  Stream<Objetivos> get objetivos {
    return _db
        .collection("objetivos")
        .doc(uid)
        .snapshots()
        .map(_objetivosFromFirebase);
  }

  Stream<UserData> get userData {
    return _db
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userDataFromFirebase);
  }

  Stream<List<Alimento>> get uAlimentos {
    return _db
        .collection("users")
        .doc(uid)
        .collection("Alimentos")
        .where("searchKeywords", arrayContains: name)
        .snapshots()
        .map(_alimentosFromFirebase);
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

  Stream<RegisterDay> get registerDay {
    return _db
        .collection("registros")
        .doc(uid)
        .collection("dias")
        .doc(_dia)
        .snapshots()
        .map(_registerDayFromFirebase);
  }

  Future<RegisterDay> day() async {
    try {
      return await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(_dia)
          .get()
          .then(_registerDayFromFirebase);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<Alimento> alimento(Map alimento) async {
    print(alimento);
    try {
      if (alimento["general"])
        return await _db
            .collection("Alimentos")
            .doc(alimento["alimento"])
            .get()
            .then((doc) => _alimentoFromFirebase(doc));
      return await _db
          .collection("users")
          .doc(uid)
          .collection("Alimentos")
          .doc(alimento["alimento"])
          .get()
          .then((doc) => _alimentoFromFirebase(doc));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future updateURL(String url) async {
    try {
      return await _db.collection("users").doc(uid).update({"profileURL": url});
    } catch (error) {
      print(error);
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
          double calorias = opt.nraciones * opt.racion["calorias"];
          Map food = {
            "alimento": alimento.id,
            "calorias": calorias,
            "descripción": alimento.description,
            "nombre": alimento.nombre,
            "general": alimento.general,
            "racion": racion,
            "raciones": opt.nraciones,
          };
          list.add(food);
          Map<String, dynamic> dia = {
            opt.option.toLowerCase(): list,
            "calorias": calorias,
            "calEjercicio": 0,
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
          list = (doc.data()[opt.option.toLowerCase()] == null)
              ? []
              : doc.data()[opt.option.toLowerCase()];
          Map racion = opt.racion;
          double calorias = opt.nraciones * opt.racion["calorias"];
          Map food = {
            "alimento": alimento.id,
            "calorias": calorias,
            "descripción": alimento.description,
            "nombre": alimento.nombre,
            "general": alimento.general,
            "racion": racion,
            "raciones": opt.nraciones,
          };
          list.add(food);
          calorias = calorias + doc.data()["calorias"];
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

  Future updateAlimento(RegisterParameters opt, Alimento alimento) async {
    try {
      return await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(DateFormat("dd-MM-yyyy").format(opt.date))
          .get()
          .then((doc) async {
        try {
          List<dynamic> list = doc.data()[opt.option.toLowerCase()];
          Map racion = opt.racion;
          Map food = {
            "alimento": alimento.id,
            "calorias": opt.nraciones * opt.racion["calorias"],
            "descripción": alimento.description,
            "general": alimento.general,
            "nombre": alimento.nombre,
            "racion": racion,
            "raciones": opt.nraciones,
          };
          list[opt.index] = food;
          double calorias = doc.data()["calorias"];
          calorias = calorias -
              doc.data()[opt.option.toLowerCase()][opt.index]["calorias"];
          calorias = calorias + opt.nraciones * opt.racion["calorias"];
          await _db
              .collection("registros")
              .doc(uid)
              .collection("dias")
              .doc(doc.data()["fecha"])
              .update({
            opt.option.toLowerCase(): list,
            "calorias": calorias,
          });
        } catch (error) {
          print(error);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future deleteFood(RegisterParameters opt) async {
    try {
      return await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(DateFormat("dd-MM-yyyy").format(opt.date))
          .get()
          .then((doc) async {
        try {
          List<dynamic> list = doc.data()[opt.option.toLowerCase()];
          double calorias =
              doc.data()["calorias"] - list[opt.index]["calorias"];
          list.removeAt(opt.index);
          await _db
              .collection("registros")
              .doc(uid)
              .collection("dias")
              .doc(doc.data()["fecha"])
              .update({opt.option.toLowerCase(): list, "calorias": calorias});
        } catch (error) {
          print(error);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future createFood(Map alimento) async {
    try {
      await _db
          .collection("users")
          .doc(uid)
          .collection("Alimentos")
          .add(HashMap.from(alimento))
          .then((doc) async {
        try {
          await doc.update({"id": doc.id});
          return doc;
        } catch (error) {
          print(error);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future addTraining(RegisterParameters opt, Map ejercicio) async {
    try {
      await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(DateFormat("dd-MM-yyyy").format(opt.date))
          .get()
          .then((doc) async {
        if (doc.data() == null) {
          List<dynamic> list = [];
          double calorias = ejercicio["calorias"];
          list.add(ejercicio);
          Map dia = {
            "ejercicio": list,
            "calEjercicio": calorias,
            "calorias": 0,
            "fecha": DateFormat("dd-MM-yyyy").format(opt.date)
          };
          await _db
              .collection("registros")
              .doc(uid)
              .collection("dias")
              .doc(DateFormat("dd-MM-yyyy").format(opt.date))
              .set(HashMap.from(dia));
        } else {
          List<dynamic> list;
          list =
              (doc.data()["ejercicio"] == null) ? [] : doc.data()["ejercicio"];
          double calorias = doc.data()["calEjercicio"] != null
              ? doc.data()["calEjercicio"] + ejercicio["calorias"]
              : ejercicio["calorias"];
          list.add(ejercicio);
          await _db
              .collection("registros")
              .doc(uid)
              .collection("dias")
              .doc(DateFormat("dd-MM-yyyy").format(opt.date))
              .update(
                  HashMap.from({"ejercicio": list, "calEjercicio": calorias}));
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future updateTraining(RegisterParameters opt, Map ejercicio) async {
    try {
      await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(DateFormat("dd-MM-yyyy").format(opt.date))
          .get()
          .then((doc) async {
        List<dynamic> list = doc.data()["ejercicio"];
        list[opt.index] = ejercicio;
        double calorias = doc.data()["calEjercicio"];
        calorias = calorias - doc.data()["ejercicio"][opt.index]["calorias"];
        calorias = calorias + ejercicio["calorias"];
        await _db
            .collection("registros")
            .doc(uid)
            .collection("dias")
            .doc(doc.data()["fecha"])
            .update({
          "ejercicio": list,
          "calEjercicio": calorias,
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future deleteTraining(RegisterParameters opt) async {
    try {
      await _db
          .collection("registros")
          .doc(uid)
          .collection("dias")
          .doc(DateFormat("dd-MM-yyyy").format(opt.date))
          .get()
          .then((doc) async {
        List<dynamic> list = doc.data()["ejercicio"];
        double calorias =
            doc.data()["calEjercicio"] - list[opt.index]["calorias"];
        list.removeAt(opt.index);
        await _db
            .collection("registros")
            .doc(uid)
            .collection("dias")
            .doc(doc.data()["fecha"])
            .update({"ejercicio": list, "calEjercicio": calorias});
      });
    } catch (error) {
      print(error);
    }
  }

  Future setObjectives(Map objetivos) async {
    try {
      await _db.collection("objetivos").doc(uid).set(HashMap.from(objetivos));
    } catch (error) {
      print(error);
    }
  }
}
