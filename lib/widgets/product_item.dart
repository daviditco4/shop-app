import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final circularBorder = BorderRadius.circular(10.0);
    final theme = Theme.of(context);
    final accentColor = theme.accentColor;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: circularBorder),
      child: ClipRRect(
        borderRadius: circularBorder,
        child: GridTile(
          child: Image.network(imageUrl, fit: BoxFit.cover),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
              color: accentColor,
            ),
            title: Text(
              title,
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
