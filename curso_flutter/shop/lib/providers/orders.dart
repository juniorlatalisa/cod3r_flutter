import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; //Alias opcional para o pacote
import 'package:shop/models/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  const Order({this.id, this.amount, this.products, this.date});
}

class Orders with ChangeNotifier {
  final _url =
      'https://flutter-cod3r-626b9-default-rtdb.firebaseio.com/orders.json';
  final _items = <Order>[];

  List<Order> get items => [..._items];

  int get size => _items.length;

  Future<Order> add(List<CartItem> products, double amount) async {
    final response = await http.post(Uri.parse(_url),
        body: json.encode({
          'amount': amount,
          'products': products
              .map((item) => {
                    'product': item.product.id,
                    'quantity': item.quantity,
                  })
              .toList(),
        }));
    final Order order = Order(
      id: json.decode(response.body)['name'],
      amount: amount,
      date: DateTime.now(),
      products: products,
    );
    _items.insert(0, order);
    notifyListeners();
    return Future.value(order);
  }
}
