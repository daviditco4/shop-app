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
    return GridTile(
      child: Image.network(imageUrl, fit: BoxFit.cover),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
        title: Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
