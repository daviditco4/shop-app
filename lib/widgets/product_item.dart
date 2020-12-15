import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  void pushProductDetailsPage(BuildContext context, String id) {
    Navigator.of(context).pushNamed('/product-details', arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final circularBorder = BorderRadius.circular(10.0);
    final theme = Theme.of(context);
    final accentColor = theme.accentColor;
    final product = Provider.of<Product>(context);

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
            leading: IconButton(
              icon: Icon(
                product.isWished ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: product.toggleWished,
              color: accentColor,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {},
              color: accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
