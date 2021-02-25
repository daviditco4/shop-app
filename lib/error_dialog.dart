import 'package:flutter/material.dart';

Widget buildErrorDialog(BuildContext context, [String message]) {
  return AlertDialog(
    title: const Text('Error'),
    content: Text(message ?? 'Something went wrong.'),
    actions: [
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('CLOSE'),
      ),
    ],
  );
}
