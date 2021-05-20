import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen();

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final theme = Theme.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrrinho'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: theme.primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: theme.primaryColor,
                  ),
                  Spacer(),
                  OrderButton(cart: cart, items: items)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(items[i]),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    @required this.items,
  }) : super(key: key);

  final Cart cart;
  final List<CartItem> items;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : TextButton(
            onPressed: widget.cart.totalAmount == 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    final order =
                        await Provider.of<Orders>(context, listen: false)
                            .add(widget.items, widget.cart.totalAmount);
                    widget.cart.clear();
                    setState(() {
                      _isLoading = false;
                    });
                    print(order.id);
                  },
            child: Text('COMPRAR'),
            //textColor: theme.primaryColor,
          );
  }
}
