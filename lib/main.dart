import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'models/products.dart';
import 'pages/product_details_page.dart';
import 'pages/products_overview_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Products(),
      child: Consumer<Products>(
        builder: (_, products, child) {
          return ChangeNotifierProvider(
            create: (_) => Cart(products),
            child: child,
          );
        },
        child: MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            primaryColorBrightness: Brightness.light,
            accentColor: Colors.purple.shade200,
            fontFamily: 'Lato',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            '/': (_) => ProductsOverviewPage(),
            '/product-details': (_) => ProductDetailsPage(),
          },
        ),
      ),
    );
  }
}
