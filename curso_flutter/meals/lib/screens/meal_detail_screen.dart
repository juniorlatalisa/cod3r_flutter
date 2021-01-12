import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(this.onToggleFavorite, this.isFavorite);

  final void Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  Widget _createSectionTitle(ThemeData theme, title) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: theme.textTheme.headline6,
        ),
      );

  Widget _createSectionContainer(Widget child, {double height = 200}) =>
      Container(
        width: 330,
        height: height,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments;
    final theme = Theme.of(context);
    // final navigate = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          //Ingredientes
          _createSectionTitle(theme, 'Ingredientes'),
          _createSectionContainer(ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: meal.ingredients.length,
            itemBuilder: (_, index) => Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Text(meal.ingredients[index]),
              ),
              color: theme.accentColor,
            ),
          )),
          //Passos
          _createSectionTitle(theme, 'Passos'),
          _createSectionContainer(
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: meal.steps.length,
              itemBuilder: (_, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(meal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
            ),
            height: meal.steps.length * 75.0,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(meal)
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
        onPressed: () => onToggleFavorite(meal),
      ),
    );
  }
}
