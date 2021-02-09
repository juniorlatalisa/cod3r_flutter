import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of(context);
    final Cart cart = Provider.of(context, listen: false);
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () =>
              navigator.pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product),
          // onTap: () => navigator.push(MaterialPageRoute(
          //   builder: (_) => ProductDetailScreen(product),
          // )),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: theme.accentColor,
            onPressed: () => products.toggleFavorite(product),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: theme.accentColor,
            onPressed: () => cart.add(product),
          ),
        ),
      ),
    );
  }
}
