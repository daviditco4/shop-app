import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart/cart.dart';
import '../../models/cart/cart_item.dart' as ci;
import '../../models/products/products.dart';

class CartItem extends StatelessWidget {
  const CartItem(this.productId);

  final String productId;

  @override
  Widget build(BuildContext context) {
    const imageSize = 40.0;
    final cartItem = Provider.of<ci.CartItem>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      child: Dismissible(
        key: ValueKey(productId),
        onDismissed: (_) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Theme.of(context).errorColor,
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.delete, size: 30.0, color: Colors.white),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: Image.network(
              Provider.of<Products>(
                context,
                listen: false,
              ).findById(productId).imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.fill,
            ),
            title: Text(cartItem.title),
            subtitle: Text('${cartItem.quantity} x \$${cartItem.price}'),
            trailing: Chip(
              backgroundColor: Theme.of(context).primaryColorDark,
              label: Text(
                '\$${cartItem.totalPrice}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
