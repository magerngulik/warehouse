// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:skripsi_warehouse/core.dart';

String? qrCode;
showQrcodeScanner(BuildContext context) async {
  qrCode = null;
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const QrCodeScannerView()),
  );

  // (const QrCodeScannerView());
  return qrCode;
}

class QrCodeScannerView extends StatefulWidget {
  const QrCodeScannerView({Key? key}) : super(key: key);

  @override
  State<QrCodeScannerView> createState() => _QrCodeScannerViewState();
}

class _QrCodeScannerViewState extends State<QrCodeScannerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WarehouseAppbar(title: "Scan Part Number"),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          qrCode = barcode.rawValue;
          if (qrCode != null) {
            Navigator.pop(context);
            debugPrint("nilai qrcode: $qrCode");
          } else {
            debugPrint("error to get text");
          }
        },
      ),
    );
  }
}
