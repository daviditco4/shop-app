import 'package:flutter/foundation.dart';

class CartItem with ChangeNotifier {
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

  double get totalPrice => price * quantity;
  String get details => '$quantity x \$$price';
  void addOneMore() => quantity++;
}
