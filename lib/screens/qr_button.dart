import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeButton extends StatelessWidget {
  final dynamic scanQr;
  const QrCodeButton({
    Key key,
    this.scanQr,
  }) : super(key: key);

  Future<void> scanQrCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'ยกเลิก', true, ScanMode.QR);
    // if (mou) {
    //   print(barcodeScanRes);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  scanQrCode();
                },
                child: Icon(Icons.qr_code))
          ],
        ),
      ),
    );
  }
}
