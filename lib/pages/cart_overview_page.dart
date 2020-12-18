import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../widgets/cart_item.dart';

class CartOverviewPage extends StatelessWidget {
  static const routeName = '/cart-overview';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    const padding15 = EdgeInsets.all(15.0);
    const largeTextStyle = TextStyle(fontSize: 20.0);
    const sizedBoxWidth = 8.0;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: padding15,
            child: Padding(
              padding: padding15,
              child: Row(
                children: [
                  const Text('Total', style: largeTextStyle),
                  const Spacer(),
                  Chip(
                    backgroundColor: theme.primaryColorDark,
                    label: Text(
                      '\$${cart.totalPrice}',
                      style: largeTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: sizedBoxWidth),
                  FlatButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(sizedBoxWidth),
                    textColor: theme.primaryColor,
                    child: const Text(
                      'ORDER NOW',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsQuantity,
              itemBuilder: (_, index) {
                final productId = cart.items.keys.elementAt(index);
                final cartItem = cart.items[productId];
                return ChangeNotifierProvider.value(
                  value: cartItem,
                  child: CartItem(productId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
