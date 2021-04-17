import 'package:flutter/widgets.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> items;

  ProductGrid(this.items);

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts = items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (_, index) => ProductGridItem(loadedProducts[index]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
