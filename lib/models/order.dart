import 'package:flutter/foundation.dart';

import 'cart_item.dart';

class Order with ChangeNotifier {
  Order({
    @required this.id,
    @required this.totalCost,
    @required this.items,
    @required this.dateTime,
  });

  final String id;
  final double totalCost;
  final List<CartItem> items;
  final DateTime dateTime;
}
