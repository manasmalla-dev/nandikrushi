import 'package:flutter/material.dart';

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
    return const Scaffold();
  }
}
