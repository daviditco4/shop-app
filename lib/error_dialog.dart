import 'package:flutter/material.dart';

Widget buildErrorDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Error'),
    content: const Text('Something went wrong.'),
    actions: [
      FlatButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('CLOSE'),
      ),
    ],
  );
}
