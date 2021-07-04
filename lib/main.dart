import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/auth/auth.dart';
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
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, previous) {
            return previous..updateAuthData(auth.token, auth.userId);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, previous) {
            return previous..updateAuthData(auth.token, auth.userId);
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (_, auth, __) {
          return ChangeNotifierProvider(
            create: (ctx) {
              return Cart(Provider.of<Products>(ctx, listen: false).findById);
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
              home: auth.isSignedIn ? ProductsOverviewPage() : AuthPage(),
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
          );
        },
      ),
    );
  }
}
