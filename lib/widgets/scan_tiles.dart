import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({
    required this.type,
    Key? key,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    // * Usually, when we are inside a build function we use lister: true.
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        direction:
            DismissDirection.endToStart, //* Swipe from right to left to dismiss
        key: UniqueKey(),
        background: Container(
          alignment: Alignment.center,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.only(left: 350),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        confirmDismiss: (DismissDirection direction) {
          return Platform.isAndroid
              ? _displayDialogAndroid(context)
              : _displayDialogIOS(context);
        },
        onDismissed: (DismissDirection direction) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Scan deleted: ${scans[index].value}")));
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScanById(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(type == 'geo' ? Icons.map_outlined : Icons.web_outlined,
              color: Theme.of(context).primaryColor),
          title: Text(scans[index].value),
          subtitle: Text('${scans[index].id}'),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () {
            print(scans[index].id);
            launchURL(context, scans[index]);
          },
        ),
      ),
    );
  }
}

Future<bool?> _displayDialogAndroid(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Scan'),
      content: const Text('Are you sure you want to delete this scan?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

Future<bool?> _displayDialogIOS(BuildContext context) {
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Delete Scan'),
      content: const Text('Are you sure you want to delete this scan?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
