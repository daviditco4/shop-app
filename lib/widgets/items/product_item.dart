import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart/cart.dart';
import '../../models/products/product.dart';
import '../../pages/store/product_details_page.dart';

class ProductItem extends StatelessWidget {
  void pushProductDetailsPage(BuildContext context, String id) {
    Navigator.of(context).pushNamed(
      ProductDetailsPage.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final circularBorder = BorderRadius.circular(10.0);
    final theme = Theme.of(context);
    final accentColor = theme.accentColor;
    final product = Provider.of<Product>(context, listen: false);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: circularBorder),
      child: ClipRRect(
        borderRadius: circularBorder,
        child: GridTile(
          child: InkWell(
            onTap: () => pushProductDetailsPage(context, product.id),
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (_, prod, __) {
                return IconButton(
                  icon: Icon(
                    prod.isWished ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: prod.toggleWished,
                  color: accentColor,
                );
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                Provider.of<Cart>(context, listen: false)
                    .addSingleProduct(product.id);
              },
              color: accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
