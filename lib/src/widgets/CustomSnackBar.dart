import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'Ocultar',
        onPressed: () {},
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
      content: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}
