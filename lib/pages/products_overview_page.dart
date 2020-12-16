import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

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
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
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
