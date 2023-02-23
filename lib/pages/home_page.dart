import 'package:flutter/material.dart';
import 'package:qr_reader/pages/directions_page.dart';
import 'package:qr_reader/pages/maps_page.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import '../providers/scan_list_provider.dart';

import '../widgets/custom_navigation_bar.dart';
import '../widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              scanListProvider.deleteAll();
            },
          ),
        ],
      ),
      body: const _HomePageBody(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //* In this point I don't want to rebuild the whole page, so I set listen to false
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsPage();
      case 1:
        scanListProvider.loadScansByType('http');
        return const DirectionsPage();
      default:
        return const MapsPage();
    }
  }
}
