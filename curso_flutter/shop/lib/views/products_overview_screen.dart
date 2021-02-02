import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) =>
                products.showFavoriteOnly = value == FilterOptions.Favorite,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Somente favoritos'),
                value: FilterOptions.Favorite,
                enabled: !products.showFavoriteOnly,
              ),
              PopupMenuItem(
                child: const Text('Todos'),
                value: FilterOptions.All,
                enabled: products.showFavoriteOnly,
              ),
            ],
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}
