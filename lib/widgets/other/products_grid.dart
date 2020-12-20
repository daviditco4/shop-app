import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products/products.dart';
import '../../pages/store/products_overview_page.dart';
import '../items/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid(this.filtering);

  final Filtering filtering;

  @override
  Widget build(BuildContext context) {
    const padding = 10.0;
    final productsProvider = Provider.of<Products>(context);
    final products = filtering == Filtering.wishedOnly
        ? productsProvider.wishedValuesOnly
        : productsProvider.values;

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
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
