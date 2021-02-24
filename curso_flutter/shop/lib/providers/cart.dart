import 'package:flutter/foundation.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  final _items = Map<String, CartItem>();

  Map<String, CartItem> get items => {..._items};

  int get size => _items.length;

  double get totalAmount => (_items.isEmpty)
      ? 0.0
      : _items.entries
          .map((i) => i.value.product.price * i.value.quantity)
          .reduce((total, subtotal) => total + subtotal);

  CartItem add(Product product) {
    final retorno = _items.containsKey(product.id)
        ? _items.update(product.id,
            (value) => CartItem(product: product, quantity: value.quantity + 1))
        : _items.putIfAbsent(
            product.id, () => CartItem(product: product, quantity: 1));
    notifyListeners();
    return retorno;
  }

  CartItem remove(String productId) {
    final item = _items.remove(productId);
    if (item != null) {
      notifyListeners();
    }
    return item;
  }
}
