import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen(this.favoriteMeal);

  final List<Meal> favoriteMeal;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Container(
        child: Text('Nenhuma refeição foi marcada como favorita!'),
      );
    }
    return ListView.builder(
      itemCount: favoriteMeal.length,
      itemBuilder: (_, index) => MealItem(favoriteMeal[index]),
    );
  }
}
