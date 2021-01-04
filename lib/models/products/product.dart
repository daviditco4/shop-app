import 'package:flutter/foundation.dart';

import '../utils/price.dart';

class Product with ChangeNotifier {
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
  final Price price;
  final String imageUrl;
  bool isWished;

  void toggleWished() {
    isWished = !isWished;
    notifyListeners();
  }

  Product copyWithId(String newId) {
    return Product(
      id: newId,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
