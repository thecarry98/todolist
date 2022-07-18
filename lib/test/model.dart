import 'package:flutter/material.dart';

class MyModel with ChangeNotifier {
  MyModel({this.someValue});
  String? someValue;
  void doSomething() {
    someValue = 'Goodbye';
    print(someValue);
    notifyListeners();
  }
}
