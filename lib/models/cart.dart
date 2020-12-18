import 'package:flutter/foundation.dart';

import 'cart_item.dart';
import 'products.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final Products productsProvider;

  Cart(this.productsProvider);

  Map<String, CartItem> get items => {..._items};

  int get itemsQuantity => _items.length;

  int get totalQuantity {
    return _items.values.fold(0, (prevVal, elem) => prevVal + elem.quantity);
  }

  double get totalPrice {
    return _items.values.fold(
      0.0,
      (prevVal, elem) => prevVal + elem.totalPrice,
    );
  }

  void addSingleProduct(String productId) {
    var product = productsProvider.findById(productId);

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

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}