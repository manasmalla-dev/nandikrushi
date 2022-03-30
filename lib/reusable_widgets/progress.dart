import 'package:flutter/material.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';

circleProgress(BuildContext context) {
  return Scaffold(
    body: SizedBox(
      width: width(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.indigo[100],
            color: Colors.indigo[900],
          ),
          SizedBox(
            height: height(context) * 0.04,
          ),
          const TextWidget(
            text: 'Please wait',
          )
        ],
      ),
    ),
  );
}

linearProgress() {
  return Scaffold(
    body: Center(
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey[100],
        color: Colors.indigo[900],
      ),
    ),
  );
}

refreshIndicator() {
  return Scaffold(
    body: Center(
        child: RefreshProgressIndicator(
      backgroundColor: Colors.grey[100],
      // valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[900])
    )),
  );
}
