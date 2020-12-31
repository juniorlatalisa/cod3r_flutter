import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoriesMealScreeen extends StatelessWidget {
  const CategoriesMealScreeen();

  @override
  Widget build(BuildContext context) {
    final Category category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('Receitas por categoria ${category.id}'),
      ),
    );
  }
}
