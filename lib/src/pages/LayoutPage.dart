import 'package:eydev_qr_scanner_and_generator/src/data/ScanBloc.dart';
import 'package:eydev_qr_scanner_and_generator/src/models/ScanModel.dart';
import 'package:eydev_qr_scanner_and_generator/src/pages/QRGeneratorPage.dart';
import 'package:eydev_qr_scanner_and_generator/src/pages/QRScanPage.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/AfterScanDialog.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/SearchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
        leading: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteDialog(context),
        ),
        title: Text('eydev - QR app'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: DataSearch(),
            ),
          ),
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
    );
  }

  Future<void> _scanQR(BuildContext context) async {
    await Permission.camera.request();
    String? scanResult = await scanner.scan();
    if (scanResult != null) {
      db.scNewScan(ScanModel(data: scanResult));
      showAfterScan(context, scanResult);
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
