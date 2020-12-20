import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          ExpansionTile(
            title: Text('\$${order.totalCost}'),
            subtitle: Text(DateFormat.yMd().add_jm().format(order.dateTime)),
          ),
        ],
      ),
    );
  }
}
