import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../cart/cart.dart';
import '../cart/cart_item.dart';
import 'order.dart';

class Orders with ChangeNotifier {
  static const url =
      'https://shop-app-a5aa4-default-rtdb.firebaseio.com/orders.json';
  final List<Order> _list = [];
  List<Order> get list => [..._list];
  int get quantity => _list.length;

  Future<void> add(Cart cart) async {
    var order = Order(
      id: null,
      totalCost: cart.totalPrice,
      items: null,
      dateTime: DateTime.now(),
    );
    final orderMap = order.toEncodableMapWithoutIdAndItems();

    try {
      var response = await http.post(url, body: json.encode(orderMap));
      order = order.copyWithId(json.decode(response.body)['name']);

      final orderItems = <CartItem>[];
      var itemMap = <String, Object>{};

      for (var cartItem in cart.items.values) {
        itemMap = cartItem.toEncodableMapWithoutId();
        response = await http.post(order.itemsUrl, body: json.encode(itemMap));

        orderItems.add(cartItem.copyWithId(json.decode(response.body)['name']));
      }

      _list.insert(0, order.copyWithItems(orderItems));
      notifyListeners();
      cart.clear();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
