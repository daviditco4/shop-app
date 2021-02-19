import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart/cart.dart';
import '../../models/products/products.dart';
import '../../widgets/other/badge.dart';
import '../../widgets/other/main_drawer.dart';
import '../../widgets/other/products_grid.dart';
import 'cart_overview_page.dart';

enum Filtering { none, wishedOnly }

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  Future<void> _refreshFuture;
  var _filtering = Filtering.none;

  @override
  void initState() {
    super.initState();
    _refreshFuture = Provider.of<Products>(context, listen: false).pull();
  }

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
            icon: const Icon(Icons.more_vert),
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
      body: FutureBuilder(
        future: _refreshFuture,
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : snapshot.hasError
                  ? const Center(child: Text('An error has ocurred.'))
                  : RefreshIndicator(
                      onRefresh: Provider.of<Products>(ctx, listen: false).pull,
                      child: ProductsGrid(_filtering),
                    );
        },
      ),
    );
  }
}
