import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/orders/order.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          ExpansionTile(
            title: Text('\$${order.totalCost}'),
            subtitle: Text(DateFormat.yMd().add_jm().format(order.dateTime)),
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 3.0,
            ),
            children: order.items.map((item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.title, style: textTheme.subtitle1),
                  Text(item.details, style: textTheme.subtitle2),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
