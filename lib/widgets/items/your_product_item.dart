import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products/product.dart';
import '../../pages/your_products/edit_product_page.dart';

class YourProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final yourProduct = Provider.of<Product>(context, listen: false);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(yourProduct.imageUrl),
      ),
      title: Text(yourProduct.title),
      subtitle: Text('\$${yourProduct.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductPage.routeName,
                arguments: yourProduct.id,
              );
            },
            color: Colors.blue,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            color: Theme.of(context).errorColor,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}