import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    final uri = Uri.parse(scan.value);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $uri';
    }
  } else {
    Navigator.pushNamed(context, '/map', arguments: scan);
  }
}
