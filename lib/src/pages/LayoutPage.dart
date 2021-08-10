import 'package:eydev_qr_scanner_and_generator/src/models/ScanBloc.dart';
import 'package:eydev_qr_scanner_and_generator/src/models/ScanModel.dart';
import 'package:eydev_qr_scanner_and_generator/src/pages/QRGeneratorPage.dart';
import 'package:eydev_qr_scanner_and_generator/src/pages/QRScanPage.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/AfterScanDialog.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final ScansBloc db = ScansBloc();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteDialog(context),
        ),
        title: Center(
          child: Text(
            'eydev - QR app',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () => _scanQR(context),
          )
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        fixedColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: 'Scans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_sharp),
            label: 'Generar',
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<void> _scanQR(BuildContext context) async {
    try {
      final String scannedQR = await FlutterBarcodeScanner.scanBarcode('#6875f5', 'Cancelar', true, ScanMode.QR);
      if (scannedQR != '-1') {
        db.scNewScan(ScanModel(data: scannedQR));
        showAfterScan(context, scannedQR);
      }
    } catch (e) {
      customSnackBar(context, 'Hubo un problema al escanear el código qr, inténtelo denuevo.');
    }
  }

  Future<void> _deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Eliminar Scans', textAlign: TextAlign.center),
        content: Text('¿Está seguro que desea eliminar todos los scans?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              db.scDeleteAllScans();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return QRScanPage();
      case 1:
        return QRGeneratorPage();
      default:
        return QRScanPage();
    }
  }
}
