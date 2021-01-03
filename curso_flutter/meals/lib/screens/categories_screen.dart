import 'package:flutter/material.dart';
import 'package:meals/components/category_item.dart';
import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen();

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5, //Proporção dos elementos
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children:
          DUMMY_CATEGORIES.map((category) => CategoryItem(category)).toList(),
    );
  }
}
