import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorPage extends StatefulWidget {
  const QRGeneratorPage({Key? key}) : super(key: key);

  @override
  _QRGeneratorPageState createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  String _data = '';
  double _sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _createQR(),
          _createSlider(),
          _crearTextfield(),
        ],
      ),
    );
  }

  Widget _crearTextfield() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: TextField(
        maxLines: null,
        onChanged: (value) {
          setState(() {
            _data = value;
          });
        },
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          icon: Icon(Icons.qr_code_2, color: Theme.of(context).accentColor),
          hintText: 'Código QR',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget _createQR() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.width - 20,
      child: Center(
        child: QrImage(
          data: _data,
          version: QrVersions.auto,
          size: (MediaQuery.of(context).size.width - 20) * _sliderValue,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _createSlider() {
    return Slider(
      activeColor: Theme.of(context).accentColor,
      value: _sliderValue,
      min: 0.3,
      max: 1,
      onChanged: (valor) {
        setState(() {
          _sliderValue = valor;
        });
      },
    );
  }
}
