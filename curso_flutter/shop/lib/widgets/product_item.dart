import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: theme.primaryColor,
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: theme.errorColor,
              onPressed: () => print(this),
            ),
          ],
        ),
      ),
    );
  }
}
