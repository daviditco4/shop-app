import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/price.dart';
import 'product.dart';

class Products with ChangeNotifier {
  static const url =
      'https://shop-app-a5aa4-default-rtdb.firebaseio.com/products.json';

  var _values = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: const Price(29.99),
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: const Price(59.99),
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: const Price(19.99),
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: const Price(49.99),
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get values => [..._values];

  List<Product> get wishedValuesOnly {
    return _values.where((value) => value.isWished).toList();
  }

  Product findById(String id) {
    return _values.firstWhere((product) => product.id == id);
  }

  Future<void> add(Product product) {
    final productMap = product.toMapWithoutId();
    productMap[Product.prcKey] = (productMap[Product.prcKey] as Price).amount;

    return http.post(url, body: json.encode(productMap)).then(
      (response) {
        _values.add(product.copyWithId(json.decode(response.body)['name']));
        notifyListeners();
      },
    );
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
