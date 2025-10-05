import 'package:flutter/material.dart';

class CounterController with ChangeNotifier {
  int counter = 0;
  String? userName;

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void increment() {
    counter++;
    notifyListeners();
  }
}
