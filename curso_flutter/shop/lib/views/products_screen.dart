import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen();

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final items = products.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => products.load(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.size,
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                ProductItem(items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
