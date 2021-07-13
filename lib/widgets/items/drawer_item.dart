import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    @required this.routeName,
    @required this.icon,
    @required this.name,
  });

  final String routeName;
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
          ..pop()
          ..pushReplacementNamed(routeName);
      },
      leading: Icon(icon),
      title: Text(name),
    );
  }
}
