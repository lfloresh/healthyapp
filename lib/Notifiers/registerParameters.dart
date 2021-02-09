import 'package:flutter/material.dart';

class RegisterParameters with ChangeNotifier {
  String _option = "";
  DateTime _dateTime = DateTime.now();
  double _nraciones = 1.0;
  int _index;
  Map _racion;

  String get option => _option;
  DateTime get date => _dateTime;
  double get nraciones => _nraciones;
  int get index => _index;
  Map get racion => _racion;

  set option(String value) {
    _option = value;
    notifyListeners();
  }

  set date(DateTime value) {
    _dateTime = value;
    notifyListeners();
  }

  set nraciones(double value) {
    _nraciones = value;
    notifyListeners();
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  set racion(Map value) {
    _racion = value;
    notifyListeners();
  }
}
