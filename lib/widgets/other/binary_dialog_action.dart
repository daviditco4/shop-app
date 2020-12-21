import 'package:flutter/material.dart';

class BinaryDialogAction extends StatelessWidget {
  const BinaryDialogAction(this.confirm);

  final bool confirm;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(confirm),
      child: Text(confirm ? 'YES' : 'NO'),
    );
  }
}
