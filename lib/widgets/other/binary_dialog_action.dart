import 'package:flutter/material.dart';

class BinaryDialogAction extends StatelessWidget {
  const BinaryDialogAction(this.confirmation);

  final bool confirmation;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(confirmation),
      child: Text(confirmation ? 'YES' : 'NO'),
    );
  }
}
