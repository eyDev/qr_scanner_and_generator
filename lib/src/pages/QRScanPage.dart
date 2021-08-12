import 'package:eydev_qr_scanner_and_generator/src/data/ScanBloc.dart';
import 'package:eydev_qr_scanner_and_generator/src/models/ScanModel.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/ScanList.dart';
import 'package:flutter/material.dart';

class QRScanPage extends StatelessWidget {
  QRScanPage({Key? key}) : super(key: key);
  final ScansBloc db = ScansBloc();

  @override
  Widget build(BuildContext context) {
    db.scGetScans();
    return StreamBuilder<List<ScanModel>>(
      stream: db.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) => ScanList(snapshot: snapshot),
    );
  }
}
