import 'package:flutter/foundation.dart';

import '../products/products.dart';
import '../utils/price.dart';
import 'cart_item.dart';

class Cart with ChangeNotifier {
  Cart(this.productsProvider);

  final Products productsProvider;
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => {..._items};
  int get itemsQuantity => _items.length;

  int get totalQuantity {
    return _items.values.fold(0, (prevVal, elem) => prevVal + elem.quantity);
  }

  Price get totalPrice {
    return _items.values.fold(
      Price(0.0),
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
          unitPrice: product.price,
          quantity: 0,
        );
      },
    );
    _items[productId].addOneMore();
    notifyListeners();
  }

  void removeSingleProduct(String productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId];

      item.removeOne();
      if (item.quantity == 0) _items.remove(productId);
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
