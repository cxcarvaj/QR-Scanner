import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/scan_list_provider.dart';
import '../widgets/list_scans.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // * Usually, when we are inside a build function we use lister: true.
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scans = scanListProvider.scans;

    return ListScansItem(icon: Icons.map, scans: scans);
  }
}
