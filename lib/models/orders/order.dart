import 'package:flutter/foundation.dart';

import '../cart/cart_item.dart';
import '../utils/price.dart';

class Order with ChangeNotifier {
  Order({
    @required this.id,
    @required this.totalCost,
    @required this.items,
    @required this.dateTime,
  });

  final String id;
  final Price totalCost;
  final List<CartItem> items;
  final DateTime dateTime;
}
