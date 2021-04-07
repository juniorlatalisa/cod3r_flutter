import 'package:flutter/foundation.dart';
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

  void add(Product product) {
    _items.add(product);
    notifyListeners();
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
