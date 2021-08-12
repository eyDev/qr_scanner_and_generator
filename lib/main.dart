import 'package:eydev_qr_scanner_and_generator/src/data/Constants.dart';
import 'package:eydev_qr_scanner_and_generator/src/pages/LayoutPage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: _constants.bgColor,
      debugShowCheckedModeBanner: false,
      title: 'eydev - QR Scanner and Generator',
      home: LayoutPage(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: _constants.bgColor,
            elevation: 0,
            centerTitle: true,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: _constants.primaryColor,
            unselectedItemColor: Colors.black,
          )),
    );
  }
}
