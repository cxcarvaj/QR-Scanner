import 'package:flutter/material.dart';

import '../widgets/scan_tiles.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // // * Usually, when we are inside a build function we use lister: true.
    // final scanListProvider = Provider.of<ScanListProvider>(context);

    // final scans = scanListProvider.scans;

    return const ScanTiles(
      type: 'geo',
    );
  }
}
