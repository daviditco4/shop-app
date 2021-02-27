import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/html_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  static String _authToken;
  var _values = <Product>[];
  List<Product> get values => [..._values];

  List<Product> get wishedValuesOnly {
    return _values.where((value) => value.isWished).toList();
  }

  static String get _url {
    return 'https://shop-app-a5aa4-default-rtdb.firebaseio.com/products.json'
        '?auth=$_authToken';
  }

  static String productUrl(Product product) {
    return _url.replaceFirst('.json', '/${product.id}.json');
  }

  void updateAuthToken(String token) => _authToken = token;

  Product findById(String id) {
    return _values.firstWhere((product) => product.id == id);
  }

  Future<void> pull() async {
    try {
      final response = await http.get(_url);
      final valuesMap = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedVals = [];

      if (valuesMap != null) {
        valuesMap.forEach(
          (prodId, prodData) {
            loadedVals.add(Product.fromIdAndDataEncodableMap(prodId, prodData));
          },
        );
      }

      _values = loadedVals;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> add(Product product) async {
    final productMap = product.toEncodableMapWithoutId();

    try {
      final response = await http.post(_url, body: json.encode(productMap));
      _values.add(product.copyWithId(json.decode(response.body)['name']));
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> replace(Product product) async {
    final productMap = product.toEncodableMapWithoutId();

    try {
      final response = await http.patch(
        productUrl(product),
        body: json.encode(productMap),
      );
      if (response.statusCode >= 400) {
        throw const HtmlException('Could not edit the product.');
      }
      _values[_values.indexWhere((prod) => prod.id == product.id)] = product;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> delete(String productId) async {
    final productIndex = _values.indexWhere((prod) => prod.id == productId);
    final product = _values.removeAt(productIndex);
    notifyListeners();

    try {
      final response = await http.delete(productUrl(product));
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
