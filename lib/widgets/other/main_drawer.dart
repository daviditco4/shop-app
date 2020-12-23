import 'package:flutter/material.dart';

import '../../pages/orders/orders_overview_page.dart';
import '../../pages/your_products/your_products_overview_page.dart';
import '../items/drawer_item.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              'Get To Shopping!',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          const DrawerItem(
            routeName: '/',
            icon: Icons.storefront,
            name: 'Store',
          ),
          const DrawerItem(
            routeName: OrdersOverviewPage.routeName,
            icon: Icons.payment,
            name: 'Orders',
          ),
          const DrawerItem(
            routeName: YourProductsOverviewPage.routeName,
            icon: Icons.monetization_on_outlined,
            name: 'Your Products',
          ),
        ],
      ),
    );
  }
}
