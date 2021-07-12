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
            child: Hero(
              tag: product.id,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/product_placeholder.png',
                image: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, prod, __) {
                final scaffoldMessenger = ScaffoldMessenger.of(ctx);

                return IconButton(
                  icon: Icon(
                    prod.isWished ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () async {
                    try {
                      await prod.toggleWished();
                    } catch (e) {
                      scaffoldMessenger.hideCurrentSnackBar();
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Could not update the wish list.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
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
                final cart = Provider.of<Cart>(context, listen: false);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                cart.addSingleProduct(product.id);
                scaffoldMessenger.hideCurrentSnackBar();
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: const Text('Product added to cart!'),
                    action: SnackBarAction(
                      onPressed: () => cart.removeSingleProduct(product.id),
                      label: 'UNDO',
                    ),
                  ),
                );
              },
              color: accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
