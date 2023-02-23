import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/widgets/list_scans.dart';
import '../providers/scan_list_provider.dart';

class DirectionsPage extends StatelessWidget {
  const DirectionsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // * Usually, when we are inside a build function we use lister: true.
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scans = scanListProvider.scans;

    return ListScansItem(icon: Icons.web_outlined, scans: scans);
  }
}
