import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/html_exception.dart';
import '../utils/price.dart';
import 'products.dart';

class Product with ChangeNotifier {
  static const idKey = 'id';
  static const uidKey = 'publisherUid';
  static const tleKey = 'title';
  static const dscKey = 'description';
  static const prcKey = 'price';
  static const imgKey = 'imageUrl';
  static const wshKey = 'isWished';

  Product({
    @required this.id,
    @required this.publisherUid,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isWished = false,
  });

  Product.fromMap(Map<String, Object> map)
      : this(
          id: map[idKey],
          publisherUid: map[uidKey],
          title: map[tleKey],
          description: map[dscKey],
          price: Price(map[prcKey]),
          imageUrl: map[imgKey],
        );

  Product.fromIdAndIsWishedAndDataEncodableMap(
    String id,
    bool isWished,
    Map<String, Object> dataMap,
  ) : this(
          id: id,
          publisherUid: dataMap[uidKey],
          title: dataMap[tleKey],
          description: dataMap[dscKey],
          price: Price(dataMap[prcKey]),
          imageUrl: dataMap[imgKey],
          isWished: isWished,
        );

  final String id;
  final String publisherUid;
  final String title;
  final String description;
  final Price price;
  final String imageUrl;
  bool isWished;

  Map<String, Object> toMap() {
    return {
      idKey: id,
      uidKey: publisherUid,
      tleKey: title,
      dscKey: description,
      prcKey: price.amount,
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
      final response = await http.put(
        Products.userWishedProductUrl(this),
        body: json.encode(isWished),
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
}
