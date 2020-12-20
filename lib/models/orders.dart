import 'package:flutter/foundation.dart';

import 'cart.dart';
import 'order.dart';

class Orders with ChangeNotifier {
  final List<Order> _list = [];

  List<Order> get list => [..._list];
  int get quantity => _list.length;

  void add(Cart cart) {
    final dateTime = DateTime.now();

    _list.insert(
      0,
      Order(
        id: dateTime.toString(),
        totalCost: cart.totalPrice,
        items: cart.items.values.toList(),
        dateTime: dateTime,
      ),
    );
    cart.clear();
    notifyListeners();
  }
}
