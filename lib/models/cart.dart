import 'package:flutter/foundation.dart';

import 'product.dart';
import 'products.dart';

class CartItem {
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });

  final String id;
  final String title;
  final double price;
  int quantity;

  void addOneMore() => quantity += 1;
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final Products productsProvider;

  Cart(this.productsProvider);

  Map<String, CartItem> get items => {..._items};

  int get totalQuantity {
    return _items.values.fold(0, (prevVal, elem) => prevVal + elem.quantity);
  }

  void addSingleProduct(String productId) {
    Product product = productsProvider.findById(productId);

    _items.putIfAbsent(
      productId,
      () {
        return CartItem(
          id: DateTime.now().toString(),
          title: product.title,
          price: product.price,
          quantity: 0,
        );
      },
    );
    _items[productId].addOneMore();
    notifyListeners();
  }
}
