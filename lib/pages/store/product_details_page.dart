import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products/products.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(id);
    const imageHeight = 275.0;
    const sizedBox = SizedBox(height: 20.0);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: imageHeight,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                sizedBox,
                Text(
                  '\$${product.price}',
                  style: textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                sizedBox,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    product.description,
                    style: textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
