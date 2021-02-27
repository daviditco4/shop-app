import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/html_exception.dart';
import '../utils/price.dart';
import 'products.dart';

class Product with ChangeNotifier {
  static const idKey = 'id';
  static const tleKey = 'title';
  static const dscKey = 'description';
  static const prcKey = 'price';
  static const imgKey = 'imageUrl';
  static const wshKey = 'isWished';

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isWished = false,
  });

  Product.fromMap(Map<String, Object> map)
      : this(
          id: map[idKey],
          title: map[tleKey],
          description: map[dscKey],
          price: map[prcKey],
          imageUrl: map[imgKey],
          isWished: map[wshKey],
        );

  Product.fromIdAndDataEncodableMap(String id, Map<String, Object> dataMap)
      : this(
          id: id,
          title: dataMap[tleKey],
          description: dataMap[dscKey],
          price: Price(dataMap[prcKey]),
          imageUrl: dataMap[imgKey],
          isWished: dataMap[wshKey],
        );

  final String id;
  final String title;
  final String description;
  final Price price;
  final String imageUrl;
  bool isWished;

  Map<String, Object> toEncodableMapWithoutId() {
    return {
      tleKey: title,
      dscKey: description,
      prcKey: price.amount,
      imgKey: imageUrl,
      wshKey: isWished,
    };
  }

  Map<String, Object> toMap() {
    return {
      idKey: id,
      tleKey: title,
      dscKey: description,
      prcKey: price,
      imgKey: imageUrl,
      wshKey: isWished,
    };
  }

  void _toggleWishedAndNotifyOnly() {
    isWished = !isWished;
    notifyListeners();
  }

  Future<void> toggleWished() async {
    _toggleWishedAndNotifyOnly();

    try {
      final response = await http.patch(
        Products.productUrl(this),
        body: json.encode({wshKey: isWished}),
      );
      if (response.statusCode >= 400) {
        throw const HtmlException('Could not update the wish list.');
      }
    } catch (e) {
      _toggleWishedAndNotifyOnly();
      print(e);
      throw e;
    }
  }

  Product copyWithId(String newId) {
    return Product(
      id: newId,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
      isWished: isWished,
    );
  }
}
