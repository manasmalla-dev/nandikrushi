import 'package:flutter/material.dart';

pickDate(BuildContext context) async {
  DateTime? date = await showDatePicker(
      confirmText: 'SET DATE',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
          DateTime.now().day - 0),
      lastDate: DateTime(DateTime.now().year + 1));
  if (date != null) {
    return date;
  }
}

picktime(BuildContext context) async {
  TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (time != null) {
    return time;
  }
}
