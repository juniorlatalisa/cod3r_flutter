import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; //Alias opcional para o pacote
import 'package:http/http.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  //https://console.firebase.google.com/project/flutter-cod3r-626b9/database/flutter-cod3r-626b9-default-rtdb/data
  //https://http2.mlstatic.com/D_NQ_NP_798682-MLB40362410711_012020-O.webp
  final _url =
      'https://flutter-cod3r-626b9-default-rtdb.firebaseio.com/products.json';
  List<Product> _items = [];
  bool _showFavoriteOnly = false;

  int get size => _items.length;

  List<Product> get items => _showFavoriteOnly
      ? _items.where((product) => product.isFavorite).toList()
      : [..._items];

  Future<void> loadProducts() async {
    if (_items.isNotEmpty) {
      return;
    }
    final response = await http.get(_url);
    Map<String, dynamic> data = json.decode(response.body);
    if (data == null || data.isEmpty) {
      dummyProduct.forEach((product) => add(product));
      return;
    }
    data.forEach((productKey, productData) => _items.add(Product(
          id: productKey,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        )));
    notifyListeners();
  }

  bool get showFavoriteOnly => _showFavoriteOnly;

  set showFavoriteOnly(value) {
    if (_showFavoriteOnly != value) {
      _showFavoriteOnly = value;
      notifyListeners();
    }
  }

  Future<bool> add(Product product) {
    return _post(product).then((response) {
      if (_onResponse(product, response)) {
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  Future<Response> _post(Product product) {
    return http.post(
      _url,
      body: json.encode({
        // 'id': product.id,
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    );
  }

  bool _onResponse(Product product, http.Response response) {
    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      _items.add(Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      return true;
    }
    return false;
  }

  void delete(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index < 0) {
      return;
    }
    _items.removeAt(index);
    notifyListeners();
  }

  void update(Product product) {
    if (product == null || product.id == null) {
      return;
    }
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index < 0) {
      return;
    }
    _items[index] = product;
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
