import 'dart:async';

import 'package:eydev_qr_scanner_and_generator/src/models/DBConnection.dart';
import 'package:eydev_qr_scanner_and_generator/src/models/ScanModel.dart';

class ScansBloc {
  static final ScansBloc scbloc = new ScansBloc._internal();

  factory ScansBloc() {
    return scbloc;
  }

  ScansBloc._internal() {
    scGetScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController.close();
  }

  scGetScans() async {
    _scansController.sink.add(await DBConnection.db.getScans());
  }

  scNewScan(ScanModel scan) async {
    await DBConnection.db.newScan(scan);
    scGetScans();
  }

  scDeleteScan(int id) async {
    await DBConnection.db.deleteScan(id);
    scGetScans();
  }

  scDeleteAllScans() async {
    DBConnection.db.deleteALlScans();
    scGetScans();
  }
}
