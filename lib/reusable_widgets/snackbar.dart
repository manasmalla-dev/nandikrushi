import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';

snackbar(BuildContext context, description,
    {bool isError = true, bool isMssg = true}) {
  final snackBar = SnackBar(
    backgroundColor: isError
        ? const Color(0xFFB31412)
        : isMssg
            ? Theme.of(context).primaryColor
            : null,
    content:
        TextWidget(description, color: Theme.of(context).colorScheme.onPrimary),
    action: SnackBarAction(
      textColor:
          isError ? Colors.white : Theme.of(context).colorScheme.onPrimary,
      label: 'Close',
      onPressed: () {},
    ),
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
