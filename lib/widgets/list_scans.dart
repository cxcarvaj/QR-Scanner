import 'package:flutter/material.dart';

import 'package:qr_reader/models/scan_model.dart';

class ListScansItem extends StatelessWidget {
  const ListScansItem({
    required this.icon,
    required this.scans,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final List<ScanModel> scans;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(scans[index].value),
        subtitle: Text('${scans[index].id}'),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () {
          print(scans[index].id);
        },
      ),
    );
  }
}
