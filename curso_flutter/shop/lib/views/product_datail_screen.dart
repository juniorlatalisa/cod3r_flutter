import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  // final Product product;

  // const ProductDetailScreen(this.product);

  const ProductDetailScreen();

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
