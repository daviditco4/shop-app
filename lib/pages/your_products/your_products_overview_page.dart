import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products/products.dart';
import '../../widgets/items/your_product_item.dart';
import '../../widgets/other/main_drawer.dart';

class YourProductsOverviewPage extends StatelessWidget {
  static const routeName = '/your-products-overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<Products>(
          builder: (_, productsProvider, __) {
            final products = productsProvider.values;
            return ListView.separated(
              itemCount: products.length,
              itemBuilder: (_, index) {
                return ChangeNotifierProvider.value(
                  value: products[index],
                  child: YourProductItem(),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            );
          },
        ),
      ),
    );
  }
}
