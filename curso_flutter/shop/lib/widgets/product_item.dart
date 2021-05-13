import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products.dart';
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
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Excluir Produto'),
                  content: Text('Remover o produto ${product.title}?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Não'),
                      onPressed: () => Navigator.of(ctx).pop(false),
                    ),
                    TextButton(
                      child: const Text('Sim'),
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ],
                ),
              )
                  .then((value) => value
                      ? Provider.of<Products>(context, listen: false)
                          .delete(product)
                      : Future.value(false))
                  .then((value) => print('Deleted: $value')),
            ),
          ],
        ),
      ),
    );
  }
}
