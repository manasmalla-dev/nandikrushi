import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

class NandikrushiNavHost extends StatefulWidget {
  final String userId;
  final String customerId;
  const NandikrushiNavHost(
      {Key? key, required this.userId, required this.customerId})
      : super(key: key);

  @override
  State<NandikrushiNavHost> createState() => _NandikrushiNavHostState();
}

class _NandikrushiNavHostState extends State<NandikrushiNavHost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextWidget("uID: ${widget.userId}, cID: ${widget.customerId}"),
      ),
    );
  }
}
