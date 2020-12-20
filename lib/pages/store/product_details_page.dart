import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products/products.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(id);
    const sizedBox = SizedBox(height: 20.0);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              width: double.infinity,
              height: 275.0,
              fit: BoxFit.cover,
            ),
            sizedBox,
            Text(
              '\$${product.price}',
              style: textTheme.headline6,
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
          ],
        ),
      ),
    );
  }
}
