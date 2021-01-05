import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products/product.dart';
import '../../models/products/products.dart';
import '../../pages/your_products/edit_product_page.dart';
import '../other/binary_dialog_action.dart';

class YourProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.title),
      subtitle: Text('\$${product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductPage.routeName,
                arguments: product.id,
              );
            },
            color: Colors.blue,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog<bool>(
                context: context,
                builder: (_) {
                  return const AlertDialog(
                    title: Text('Your product will be deleted'),
                    content: Text('Are you sure?'),
                    actions: [
                      BinaryDialogAction(true),
                      BinaryDialogAction(false),
                    ],
                  );
                },
              ).then(
                (confirmation) {
                  if (confirmation) {
                    Provider.of<Products>(
                      context,
                      listen: false,
                    ).delete(product.id);
                  }
                },
              );
            },
            color: Theme.of(context).errorColor,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
