import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/auth/auth.dart';
import 'models/cart/cart.dart';
import 'models/orders/orders.dart';
import 'models/products/products.dart';
import 'pages/auth/auth_page.dart';
import 'pages/orders/orders_overview_page.dart';
import 'pages/other/splash_page.dart';
import 'pages/store/cart_overview_page.dart';
import 'pages/store/product_details_page.dart';
import 'pages/store/products_overview_page.dart';
import 'pages/your_products/edit_product_page.dart';
import 'pages/your_products/your_products_overview_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void _setNavigateToAuth(Auth auth, BuildContext context) {
    auth.navigateToSignin = () {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: MultiProvider(
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
          ChangeNotifierProxyProvider<Products, Cart>(
            create: (_) => Cart(),
            update: (_, products, prv) => prv..updateProducts(products.values),
          ),
        ],
        child: Consumer<Auth>(
          builder: (_, auth, __) {
            return MaterialApp(
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
              routes: {
                '/': (ctx) {
                  _setNavigateToAuth(auth, ctx);

                  return auth.isSignedIn
                      ? ProductsOverviewPage()
                      : FutureBuilder(
                          future: auth.attemptAutoSignin(),
                          builder: (_, snap) {
                            return snap.connectionState != ConnectionState.done
                                ? SplashPage()
                                : AuthPage();
                          },
                        );
                },
                ProductDetailsPage.routeName: (ctx) {
                  _setNavigateToAuth(auth, ctx);
                  return ProductDetailsPage();
                },
                CartOverviewPage.routeName: (ctx) {
                  _setNavigateToAuth(auth, ctx);
                  return CartOverviewPage();
                },
                OrdersOverviewPage.routeName: (ctx) {
                  _setNavigateToAuth(auth, ctx);
                  return OrdersOverviewPage();
                },
                YourProductsOverviewPage.routeName: (ctx) {
                  _setNavigateToAuth(auth, ctx);
                  return YourProductsOverviewPage();
                },
                EditProductPage.routeName: (ctx) {
                  _setNavigateToAuth(auth, ctx);
                  return EditProductPage();
                },
              },
            );
          },
        ),
      ),
    );
  }
}
