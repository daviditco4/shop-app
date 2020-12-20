import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../widgets/badge.dart';
import '../widgets/main_drawer.dart';
import '../widgets/products_grid.dart';
import 'cart_overview_page.dart';

enum Filtering { none, wishedOnly }

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _filtering = Filtering.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, child) {
              return Badge(value: '${cart.totalQuantity}', child: child);
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartOverviewPage.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (filtering) => setState(() => _filtering = filtering),
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: Filtering.wishedOnly,
                child: Text('Show products you wish only'),
              ),
              PopupMenuItem(value: Filtering.none, child: Text('Show all')),
            ],
          ),
        ],
      ),
      body: ProductsGrid(_filtering),
    );
  }
}
