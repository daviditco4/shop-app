import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/price.dart';
import 'product.dart';

class Products with ChangeNotifier {
  static const _url =
      'https://shop-app-a5aa4-default-rtdb.firebaseio.com/products.json';
  List<Product> _values = [];
  List<Product> get values => [..._values];

  List<Product> get wishedValuesOnly {
    return _values.where((value) => value.isWished).toList();
  }

  Product findById(String id) {
    return _values.firstWhere((product) => product.id == id);
  }

  Future<void> pull() async {
    try {
      final response = await http.get(_url);
      final valuesMap = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedValues = [];

      valuesMap.forEach(
        (productId, productData) {
          loadedValues.insert(
            0,
            Product(
              id: productId,
              title: productData[Product.tleKey],
              description: productData[Product.dscKey],
              price: Price(productData[Product.prcKey]),
              imageUrl: productData[Product.imgKey],
              isWished: productData[Product.wshKey],
            ),
          );
        },
      );

      _values = loadedValues;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> add(Product product) async {
    final productMap = product.toMapWithoutId();
    productMap[Product.prcKey] = (productMap[Product.prcKey] as Price).amount;

    try {
      final response = await http.post(_url, body: json.encode(productMap));
      _values.add(product.copyWithId(json.decode(response.body)['name']));
      notifyListeners();
    } catch (e) {
      print('Error in products.dart: $e');
      throw e;
    }
  }

  void replace(Product product) {
    _values[_values.indexWhere((prod) => prod.id == product.id)] = product;
    notifyListeners();
  }

  void delete(String productId) {
    _values.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
