import 'package:eydev_qr_scanner_and_generator/src/data/Constants.dart';
import 'package:eydev_qr_scanner_and_generator/src/data/ScanBloc.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/CustomSnackBar.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/LaunchUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanList extends StatelessWidget {
  const ScanList({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final Constants _constants = Constants();
    final ScansBloc db = ScansBloc();
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }
    final scans = snapshot.data;
    if (scans!.length == 0) {
      return Center(
        child: Image.asset(
          'assets/empty.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
      );
    }
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (context, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: _constants.primaryColor),
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
  }
}
