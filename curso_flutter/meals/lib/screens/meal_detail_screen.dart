import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen();

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(children: <Widget>[
        Container(
          height: 300,
          width: double.infinity,
          child: Image.network(
            meal.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Ingredientes',
            style: theme.textTheme.headline6,
          ),
        ),
        Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: ListView.builder(
            itemCount: meal.ingredients.length,
            itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Text(meal.ingredients[index]),
              ),
              color: theme.accentColor,
            ),
          ),
        ),
      ]),
    );
  }
}
