import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('${item.product.price}'),
              ),
            ),
          ),
          title: Text(item.product.title),
          subtitle: Text('Total: R\$ ${item.quantity * item.product.price}'),
          trailing: Text('${item.quantity}x'),
        ),
      ),
    );
  }
}
