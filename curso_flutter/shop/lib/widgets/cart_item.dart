import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(item.product.id),
      background: Container(
        color: theme.errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      // confirmDismiss: (direction) => Future.value(false),
      confirmDismiss: (_) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Tem certeza?'),
          content: const Text('Quer remover o item do carrinho?'),
          actions: <Widget>[
            TextButton(
              child: Text('Não'),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () => Navigator.of(ctx).pop(true),
            ),
          ],
        ),
      ),
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).remove(item.product.id),
      child: Card(
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
      ),
    );
  }
}
