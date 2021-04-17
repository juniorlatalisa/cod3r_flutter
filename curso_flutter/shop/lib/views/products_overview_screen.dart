import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen();

  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of(context);
    products.loadProducts();
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
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.CART_DETAIL),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.size.toString(),
              child: child,
            ),
          )
        ],
      ),
      body: ProductGrid(),
      drawer: AppDrawer(),
    );
  }
}
