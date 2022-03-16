import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

launchCaller() async {
  const url = "tel:1234567";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void launchEmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'info@spotmies.com',
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    log('Could not launch $url');
  }
}
