import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; //Alias opcional para o pacote
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProduct;
  bool _showFavoriteOnly = false;

  int get size => _items.length;

  List<Product> get items => _showFavoriteOnly
      ? _items.where((product) => product.isFavorite).toList()
      : [..._items];

  bool get showFavoriteOnly => _showFavoriteOnly;

  set showFavoriteOnly(value) {
    if (_showFavoriteOnly != value) {
      _showFavoriteOnly = value;
      notifyListeners();
    }
  }

  Future<bool> add(Product product) {
    //https://console.firebase.google.com/project/flutter-cod3r-626b9/database/flutter-cod3r-626b9-default-rtdb/data
    //https://http2.mlstatic.com/D_NQ_NP_798682-MLB40362410711_012020-O.webp
    const url =
        'https://flutter-cod3r-626b9-default-rtdb.firebaseio.com/products.json';
    return http
        .post(
          url,
          body: json.encode({
            // 'id': product.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }),
        )
        .then((response) => _add(product, response));
  }

  bool _add(Product product, http.Response response) {
    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      _items.add(Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      notifyListeners();
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
