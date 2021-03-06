import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; //Alias opcional para o pacote
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_firebase.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  final String userId;

  const Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
    @required this.userId,
  });
}

class Orders with ChangeNotifier {
  Orders([
    this._token,
    this._userId,
    this._items = const [],
  ]) : this._url = '${AppFireBase.BASE_API_URL}/orders/$_userId.json';

  final List<Order> _items;
  final String _token;
  final String _userId;
  //final _url = '${AppFireBase.BASE_API_URL}/$_userId/orders.json';
  final String _url;

  List<Order> get items => [..._items];

  int get size => _items.length;

  Future<void> load(Map<String, Product> products) async {
    if (_items.isNotEmpty) {
      return;
    }
    final response = await http.get(Uri.parse('$_url?auth=$_token'));
    if (response.statusCode != 200) {
      print(response.body);
      return;
    }
    Map<String, dynamic> data = json.decode(response.body);
    if (data == null || data.isEmpty) {
      print('Empty orders');
      return;
    }
    data.forEach((orderyKey, orderData) => _items.add(Order(
          id: orderyKey,
          userId: _userId,
          date: DateTime.parse(orderData['date']),
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    product: products[item['product']],
                    quantity: item['quantity'],
                  ))
              .toList(),
        )));
    notifyListeners();
  }

  Future<Order> add(List<CartItem> products, double amount) async {
    final date = DateTime.now();
    final response = await http.post(Uri.parse('$_url?auth=$_token'),
        body: json.encode({
          'amount': amount,
          'date': date.toIso8601String(),
          'products': products
              .map((item) => {
                    'product': item.product.id,
                    'quantity': item.quantity,
                  })
              .toList(),
        }));
    final Order order = Order(
      id: json.decode(response.body)['name'],
      userId: _userId,
      amount: amount,
      date: date,
      products: products,
    );
    _items.insert(0, order);
    notifyListeners();
    return Future.value(order);
  }
}
