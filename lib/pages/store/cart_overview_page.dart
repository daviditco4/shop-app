import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/error_dialog.dart';

import '../../models/cart/cart.dart';
import '../../models/orders/orders.dart';
import '../../widgets/items/cart_item.dart';
import '../orders/orders_overview_page.dart';

class CartOverviewPage extends StatefulWidget {
  static const routeName = '/cart-overview';

  @override
  _CartOverviewPageState createState() => _CartOverviewPageState();
}

class _CartOverviewPageState extends State<CartOverviewPage> {
  var _isLoading = false;

  Future<void> placeOrder() async {
    final cart = Provider.of<Cart>(context, listen: false);
    final navigator = Navigator.of(context);
    setState(() => _isLoading = true);

    try {
      await Provider.of<Orders>(context, listen: false).add(cart);
      navigator.pop();
      navigator.pushReplacementNamed(OrdersOverviewPage.routeName);
    } catch (e) {
      await showDialog<Null>(context: context, builder: buildErrorDialog);
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    const padding15 = EdgeInsets.all(15.0);
    const sizedBoxWidth = 8.0;
    final theme = Theme.of(context);
    final cartItems = cart.items;
    final cartItemsKeys = cartItems.keys;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Card(
                  margin: padding15,
                  child: Padding(
                    padding: padding15,
                    child: Row(
                      children: [
                        Text('Total', style: theme.textTheme.headline6),
                        const Spacer(),
                        Chip(
                          backgroundColor: theme.primaryColorDark,
                          label: Text(
                            '\$${cart.totalPrice}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: sizedBoxWidth),
                        TextButton(
                          onPressed:
                              cart.itemsQuantity == 0 ? null : placeOrder,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(sizedBoxWidth),
                            ),
                          ),
                          child: Text(
                            'ORDER NOW',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
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
                      final productId = cartItemsKeys.elementAt(index);
                      final cartItem = cartItems[productId];
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
