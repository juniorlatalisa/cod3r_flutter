import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/models/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  const Order({this.id, this.amount, this.products, this.date});
}

class Orders with ChangeNotifier {
  final _items = <Order>[];

  List<Order> get items => [..._items];

  int get size => _items.length;

  void add(List<CartItem> products, double amount) {
    _items.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          amount: amount,
          date: DateTime.now(),
          products: products,
        ));
    notifyListeners();
  }
}
