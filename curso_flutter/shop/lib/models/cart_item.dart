import 'package:flutter/foundation.dart';
import 'package:shop/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    @required this.product,
    @required this.quantity,
  });
}
