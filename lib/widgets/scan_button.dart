import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancel',
        //   false,
        //   ScanMode.QR,
        // );
        final barcodeScanRes = 'https://fernando-herrera.com';
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        scanListProvider.newScan(barcodeScanRes);
        scanListProvider.newScan('geo:13.12,123.12');
      },
      child: const Icon(Icons.qr_code_scanner),
    );
  }
}
