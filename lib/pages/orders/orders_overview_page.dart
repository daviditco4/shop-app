import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/orders/orders.dart';
import '../../widgets/items/order_item.dart';
import '../../widgets/other/main_drawer.dart';

class OrdersOverviewPage extends StatefulWidget {
  static const routeName = '/orders-overview';

  @override
  _OrdersOverviewPageState createState() => _OrdersOverviewPageState();
}

class _OrdersOverviewPageState extends State<OrdersOverviewPage> {
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Orders>(
      context,
      listen: false,
    ).pull().then((_) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    final ordersList = orders.list;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text('Your Orders')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: orders.pull,
              child: ListView.builder(
                itemCount: ordersList.length,
                itemBuilder: (_, index) {
                  return ChangeNotifierProvider.value(
                    value: ordersList[index],
                    child: OrderItem(),
                  );
                },
              ),
            ),
    );
  }
}
