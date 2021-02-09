import 'package:flutter/material.dart';

class CurrentPage with ChangeNotifier {
  String _namePage = "Home";

  String get page => _namePage;

  set page(String value) {
    _namePage = value;
    notifyListeners();
  }
}
