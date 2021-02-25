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
  final _orders = <Order>[];

  List<Order> get orders => [..._orders];

  void add(List<CartItem> products, double amount) {
    _orders.insert(
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
