import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/counter_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  // final Product product;

  // const ProductDetailScreen(this.product);

  const ProductDetailScreen();

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    final counterProvider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Text(counterProvider.state.value.toString()),
          RaisedButton(
            child: const Text('+'),
            onPressed: () => setState(() => print(counterProvider.state.inc())),
          )
        ],
      ),
    );
  }
}
