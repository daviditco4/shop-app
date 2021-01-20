import 'package:flutter/foundation.dart';

import '../utils/price.dart';

class CartItem with ChangeNotifier {
  CartItem({
    @required this.id,
    @required this.title,
    @required this.unitPrice,
    @required this.quantity,
  });

  final String id;
  final String title;
  final Price unitPrice;
  int quantity;
  Price get totalPrice => unitPrice * quantity;
  String get details => '\$$unitPrice x $quantity';
  void addOneMore() => quantity++;
  void removeOne() => quantity--;
}
