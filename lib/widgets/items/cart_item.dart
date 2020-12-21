import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart/cart.dart';
import '../../models/cart/cart_item.dart' as ci;
import '../../models/products/products.dart';
import '../other/binary_dialog_action.dart';

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
        direction: DismissDirection.startToEnd,
        onDismissed: (_) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        confirmDismiss: (_) {
          return showDialog(
            context: context,
            builder: (_) {
              return const AlertDialog(
                title: Text('This item will be removed'),
                content: Text('Are you sure?'),
                actions: [BinaryDialogAction(true), BinaryDialogAction(false)],
              );
            },
          );
        },
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
            subtitle: Text(cartItem.details),
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
