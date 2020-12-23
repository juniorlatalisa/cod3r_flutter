import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5, //Proporção dos elementos
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [],
    );
  }
}
