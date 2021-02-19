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
  Future<void> _refreshFuture;

  @override
  void initState() {
    super.initState();
    _refreshFuture = Provider.of<Orders>(context, listen: false).pull();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text('Your Orders')),
      body: FutureBuilder(
        future: _refreshFuture,
        builder: (_, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : snapshot.hasError
                  ? const Center(child: Text('An error has ocurred.'))
                  : Consumer<Orders>(
                      builder: (_, orders, __) {
                        final ordersList = orders.list;
                        return RefreshIndicator(
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
                        );
                      },
                    );
        },
      ),
    );
  }
}
