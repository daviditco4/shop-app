import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart/cart.dart';
import 'models/orders/orders.dart';
import 'models/products/products.dart';
import 'pages/auth/auth_page.dart';
import 'pages/orders/orders_overview_page.dart';
import 'pages/store/cart_overview_page.dart';
import 'pages/store/product_details_page.dart';
import 'pages/store/products_overview_page.dart';
import 'pages/your_products/edit_product_page.dart';
import 'pages/your_products/your_products_overview_page.dart';

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
            primaryTextTheme: const TextTheme(
              headline3: TextStyle(
                fontSize: 50.0,
                fontFamily: 'Anton',
                color: Colors.white,
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthPage(),
          routes: {
            ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
            CartOverviewPage.routeName: (_) => CartOverviewPage(),
            OrdersOverviewPage.routeName: (_) => OrdersOverviewPage(),
            YourProductsOverviewPage.routeName: (_) {
              return YourProductsOverviewPage();
            },
            EditProductPage.routeName: (_) => EditProductPage(),
          },
        ),
      ),
    );
  }
}
