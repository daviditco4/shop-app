import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const padding = 10.0;
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.values;

    return GridView.builder(
      padding: const EdgeInsets.all(padding),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        mainAxisSpacing: padding,
        crossAxisSpacing: padding,
        childAspectRatio: 3.0 / 2.0,
      ),
      itemCount: products.length,
      itemBuilder: (_, index) {
        return ChangeNotifierProvider(
          create: (_) => products[index],
          child: ProductItem(),
        );
      },
    );
  }
}