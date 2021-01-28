import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of(context, listen: false);
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
          leading: Consumer<Product>(
            builder: (ctx, prd, _) => IconButton(
              icon:
                  Icon(prd.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: theme.accentColor,
              onPressed: () => prd.toggleFavorite(),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: theme.accentColor,
            onPressed: () =>
                //Pensei que não funcionaria
                product.toggleFavorite(),
            // Provider.of<Product>(context, listen: false).toggleFavorite(),
          ),
        ),
      ),
    );
  }
}
