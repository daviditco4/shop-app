import 'package:flutter/foundation.dart';

import '../utils/price.dart';

class CartItem with ChangeNotifier {
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });

  final String id;
  final String title;
  final Price price;
  int quantity;

  Price get totalPrice => price * quantity;
  String get details => '$quantity x \$$price';
  void addOneMore() => quantity++;
}
