import 'package:flutter/foundation.dart';

class Product {
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isWished = false,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isWished;
}
