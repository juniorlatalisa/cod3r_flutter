import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/utils/app_routes.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    final theme = Theme.of(context);
    // final navigator = Navigator.of(context);
    return InkWell(
      // onTap: () => navigator.push(MaterialPageRoute(
      //   builder: (_) => CategoriesMealScreeen(category),
      // )),
      onTap: () => AppRoutes.categoriesMealNavigate(context, category),
      splashColor: theme.primaryColor,
      borderRadius: borderRadius,
      child: Container(
        child: Text(
          category.title,
          style: theme.textTheme.headline6,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
          ),
        ),
      ),
    );
  }
}
