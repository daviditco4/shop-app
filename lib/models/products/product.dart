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
      : assert(map.containsKey(idKey) &&
            (map[idKey].runtimeType == String ||
                map[idKey].runtimeType == Null)),
        assert(map.containsKey(tleKey) && map[tleKey].runtimeType == String),
        assert(map.containsKey(dscKey) && map[dscKey].runtimeType == String),
        assert(map.containsKey(prcKey) && map[prcKey].runtimeType == Price),
        assert(map.containsKey(imgKey) && map[imgKey].runtimeType == String),
        assert(map.containsKey(wshKey) && map[wshKey].runtimeType == bool),
        id = map[idKey],
        title = map[tleKey],
        description = map[dscKey],
        price = map[prcKey],
        imageUrl = map[imgKey],
        isWished = map[wshKey];

  final String id;
  final String title;
  final String description;
  final Price price;
  final String imageUrl;
  bool isWished;

  String get url => Products.url.replaceFirst('.json', '/$id.json');

  Map<String, Object> toMapWithoutId() {
    return {
      tleKey: title,
      dscKey: description,
      prcKey: price,
      imgKey: imageUrl,
      wshKey: isWished,
    };
  }

  Map<String, Object> toMapWithId() {
    final Map<String, Object> map = {idKey: id};
    map.addAll(toMapWithoutId());
    return map;
  }

  Future<void> toggleWished() async {
    isWished = !isWished;
    notifyListeners();

    try {
      final res = await http.patch(url, body: json.encode({wshKey: isWished}));
      if (res.statusCode >= 400) {
        throw const HtmlException('Could not update the wish list.');
      }
    } catch (e) {
      isWished = !isWished;
      notifyListeners();
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
    );
  }
}
