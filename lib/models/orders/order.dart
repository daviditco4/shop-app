import 'package:flutter/foundation.dart';

import '../cart/cart_item.dart';
import '../utils/price.dart';
import 'orders.dart';

class Order with ChangeNotifier {
  Order({
    @required this.id,
    @required this.totalCost,
    @required this.items,
    @required this.dateTime,
  });

  Order.fromIdItemsAndDataEncodableMap(
    String id,
    List<CartItem> items,
    Map<String, Object> dataMap,
  ) : this(
          id: id,
          totalCost: Price(dataMap['totalCost']),
          items: items,
          dateTime: DateTime.parse(dataMap['dateTime']),
        );

  final String id;
  final Price totalCost;
  final List<CartItem> items;
  final DateTime dateTime;

  Order copyWithId(String newId) {
    return Order(
      id: newId,
      totalCost: totalCost,
      items: items,
      dateTime: dateTime,
    );
  }

  Order copyWithItems(List<CartItem> newItems) {
    return Order(
      id: id,
      totalCost: totalCost,
      items: newItems,
      dateTime: dateTime,
    );
  }

  String get itemsUrl => Orders.url.replaceFirst('.json', '/$id/items.json');

  Map<String, Object> toEncodableMapWithoutIdAndItems() {
    return {'totalCost': totalCost.amount, 'dateTime': '$dateTime'};
  }
}
