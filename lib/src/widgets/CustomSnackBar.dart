import 'package:eydev_qr_scanner_and_generator/src/data/Constants.dart';
import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String text) {
  final Constants _constants = Constants();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'Ocultar',
        textColor: Colors.white,
        onPressed: () {},
      ),
      backgroundColor: _constants.primaryColor,
      duration: Duration(seconds: 3),
      content: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}
