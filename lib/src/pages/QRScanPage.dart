import 'package:eydev_qr_scanner_and_generator/src/models/ScanBloc.dart';
import 'package:eydev_qr_scanner_and_generator/src/models/ScanModel.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/CustomSnackBar.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/LaunchUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRScanPage extends StatelessWidget {
  QRScanPage({Key? key}) : super(key: key);
  final ScansBloc db = ScansBloc();

  @override
  Widget build(BuildContext context) {
    db.scGetScans();
    return StreamBuilder<List<ScanModel>>(
      stream: db.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if (scans!.length == 0) {
          return Center(
            child: Image.asset('assets/empty.png'),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Color.fromRGBO(104, 117, 245, 1)),
            onDismissed: (direction) => db.scDeleteScan(scans[i].id!),
            child: ListTile(
              trailing: IconButton(
                onPressed: () => launchURL(scans[i].data),
                icon: Icon(Icons.launch),
              ),
              onTap: () => Clipboard.setData(ClipboardData(text: scans[i].data))
                  .then((value) => customSnackBar(context, 'Copiado al portapapeles!'))
                  .catchError((onError) => customSnackBar(context, 'Error al copiar al portapapeles!')),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(scans[i].data),
            ),
          ),
        );
      },
    );
  }
}
