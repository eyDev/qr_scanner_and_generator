import 'package:flutter/material.dart';

class Constants {
  static final Constants _instancia = new Constants._();
  factory Constants() {
    return _instancia;
  }
  Constants._();

  Color get primaryColor => Color.fromRGBO(104, 117, 245, 1);
  Color get bgColor => Color.fromRGBO(29, 35, 48, 1);
}
