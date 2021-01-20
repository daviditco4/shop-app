import 'package:flutter/foundation.dart';

import '../utils/price.dart';

class CartItem with ChangeNotifier {
  CartItem({
    @required this.id,
    @required this.title,
    @required this.unitPrice,
    @required this.quantity,
  });

  CartItem.fromIdAndDataEncodableMap(String id, Map<String, Object> dataMap)
      : this(
          id: id,
          title: dataMap['title'],
          unitPrice: Price(dataMap['unitPrice']),
          quantity: dataMap['quantity'],
        );

  final String id;
  final String title;
  final Price unitPrice;
  int quantity;
  Price get totalPrice => unitPrice * quantity;
  String get details => '\$$unitPrice x $quantity';
  void addOneMore() => quantity++;
  void removeOne() => quantity--;

  Map<String, Object> toEncodableMapWithoutId() {
    return {
      'title': title,
      'unitPrice': unitPrice.amount,
      'quantity': quantity,
    };
  }

  CartItem copyWithId(String newId) {
    return CartItem(
      id: newId,
      title: title,
      unitPrice: unitPrice,
      quantity: quantity,
    );
  }
}
