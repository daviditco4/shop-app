import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text(id)),
    );
  }
}
