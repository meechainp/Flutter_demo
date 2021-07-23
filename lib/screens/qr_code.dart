import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_demo/screens/qr_button.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({Key key}) : super(key: key);

  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: QrCodeButton(
          // scanQr: scanQrCode(),
        ),
      ),
    );
  }
}
