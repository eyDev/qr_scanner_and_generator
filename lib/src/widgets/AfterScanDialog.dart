import 'package:eydev_qr_scanner_and_generator/src/widgets/CustomSnackBar.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/LaunchUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showAfterScan(BuildContext context, String value) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Icon(Icons.qr_code, size: 40),
        titlePadding: EdgeInsets.symmetric(vertical: 20),
        content: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).primaryColor)),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
                child: Text(
                  'Cerrar',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  Clipboard.setData(ClipboardData(text: value))
                      .then((value) => customSnackBar(context, 'Copiado al portapapeles!'))
                      .catchError((onError) => customSnackBar(context, 'Error al copiar al portapapeles!'))
                },
                child: Text(
                  'Copiar',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  launchURL(value),
                },
                child: Text(
                  'Abrir',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
