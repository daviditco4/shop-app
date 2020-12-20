import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart/cart.dart';
import 'models/orders/orders.dart';
import 'models/products/products.dart';
import 'pages/orders/orders_overview_page.dart';
import 'pages/store/cart_overview_page.dart';
import 'pages/store/product_details_page.dart';
import 'pages/store/products_overview_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
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
            ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
            CartOverviewPage.routeName: (_) => CartOverviewPage(),
            OrdersOverviewPage.routeName: (_) => OrdersOverviewPage(),
          },
        ),
      ),
    );
  }
}
