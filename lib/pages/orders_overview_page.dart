import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/orders.dart';
import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart';

class OrdersOverviewPage extends StatelessWidget {
  static const routeName = '/orders-overview';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context, listen: false);
    final ordersList = orders.list;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text('Your Orders')),
      body: ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (_, index) {
          return ChangeNotifierProvider.value(
            value: ordersList[index],
            child: OrderItem(),
          );
        },
      ),
    );
  }
}
