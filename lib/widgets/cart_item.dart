import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart' as ci;
import '../models/products.dart';

class CartItem extends StatelessWidget {
  const CartItem(this.productId);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<ci.CartItem>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      child: ListTile(
        leading: Consumer<Products>(
          builder: (_, products, __) {
            const imageSize = 40.0;
            return Image.network(
              products.findById(productId).imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.fill,
            );
          },
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
    );
  }
}
