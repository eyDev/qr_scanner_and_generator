import 'package:eydev_qr_scanner_and_generator/src/pages/LayoutPage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color.fromRGBO(11, 11, 16, 1),
      debugShowCheckedModeBanner: false,
      title: 'eydev - QR Scanner and Generator',
      home: LayoutPage(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(11, 11, 16, 1),
        accentColor: Color.fromRGBO(104, 117, 245, 1),
      ),
    );
  }
}
