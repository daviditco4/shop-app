import 'package:flutter/material.dart';

import 'pages/product_details_page.dart';
import 'pages/products_overview_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
