import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({@required this.child, @required this.value, this.color});

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const offset = 8.0;
    const minSize = 16.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: offset,
          top: offset,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            padding: const EdgeInsets.all(2.0),
            constraints: BoxConstraints(
              minWidth: minSize,
              minHeight: minSize,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10.0),
            ),
          ),
        ),
      ],
    );
  }
}
