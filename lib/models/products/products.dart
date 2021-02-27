import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/html_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  static const _serverUrl =
      'https://shop-app-a5aa4-default-rtdb.firebaseio.com';
  static String _authToken;
  static String _userId;
  var _values = <Product>[];
  List<Product> get values => [..._values];

  List<Product> get wishedValuesOnly {
    return _values.where((value) => value.isWished).toList();
  }

  static String get _url => '$_serverUrl/products.json?auth=$_authToken';

  static String _productUrl(Product product) {
    return _url.replaceFirst('.json', '/${product.id}.json');
  }

  static String get _userWishedUrl {
    return '$_serverUrl/user-wished/$_userId.json?auth=$_authToken';
  }

  static String userWishedProductUrl(Product product) {
    return _userWishedUrl.replaceFirst('.json', '/${product.id}.json');
  }

  void updateAuthData(String token, String userId) {
    _authToken = token;
    _userId = userId;
  }

  Product findById(String id) => _values.firstWhere((prod) => prod.id == id);

  Future<void> pull() async {
    try {
      var response = await http.get(_url);
      final valuesMap = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedVals = [];

      if (valuesMap != null) {
        response = await http.get(_userWishedUrl);
        final usrWishedMap = json.decode(response.body) as Map<String, dynamic>;

        valuesMap.forEach(
          (prodId, prodData) {
            loadedVals.add(
              Product.fromIdAndIsWishedAndDataEncodableMap(
                prodId,
                usrWishedMap == null ? false : usrWishedMap[prodId] ?? false,
                prodData,
              ),
            );
          },
        );
      }

      _values = loadedVals;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> add(Map<String, Object> productMap) async {
    try {
      final response = await http.post(_url, body: json.encode(productMap));
      productMap[Product.idKey] = json.decode(response.body)['name'];
      _values.add(Product.fromMap(productMap));
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> edit(Map<String, Object> productMap) async {
    final product = Product.fromMap(productMap);
    productMap.remove(Product.idKey);
    productMap.remove(Product.wshKey);

    try {
      final response = await http.patch(
        _productUrl(product),
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
      final response = await http.delete(_productUrl(product));
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
