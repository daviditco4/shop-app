import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/html_exception.dart';
import '../utils/price.dart';
import 'product.dart';

class Products with ChangeNotifier {
  static const url =
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
      final response = await http.get(url);
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
      final response = await http.post(url, body: json.encode(productMap));
      _values.add(product.copyWithId(json.decode(response.body)['name']));
      notifyListeners();
    } catch (e) {
      print('Error in products.dart: $e');
      throw e;
    }
  }

  Future<void> replace(Product product) async {
    final productMap = product.toMapWithoutId();
    productMap[Product.prcKey] = (productMap[Product.prcKey] as Price).amount;

    try {
      await http.patch(product.url, body: json.encode(productMap));
      _values[_values.indexWhere((prod) => prod.id == product.id)] = product;
      notifyListeners();
    } catch (e) {
      print('Error in products.dart: $e');
      throw e;
    }
  }

  Future<void> delete(String productId) async {
    final productIndex = _values.indexWhere((prod) => prod.id == productId);
    final product = _values.removeAt(productIndex);
    notifyListeners();

    try {
      final response = await http.delete(product.url);
      if (response.statusCode >= 400) {
        throw const HtmlException('Could not delete the product.');
      }
    } catch (e) {
      _values.insert(productIndex, product);
      notifyListeners();
      print(e);
      throw e;
    }
  }
}
