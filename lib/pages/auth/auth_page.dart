import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/other/auth_form.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEA80FC), Color(0xFFFCE4EC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                transform: Matrix4.rotationZ(-8.0 * pi / 180.0)
                  ..translate(-10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: theme.primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Colors.black54,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 65.0,
                ),
                child: Text('ShopApp', style: theme.primaryTextTheme.headline3),
              ),
              AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
