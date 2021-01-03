import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';

class AppRoutes {
  static const _homeScreen = CategoriesScreen();
  static const _categoriesMealScreeen = CategoriesMealScreeen();
  static const _mealDetailScreen = MealDetailScreen();

  static const MEAL_DETAIL = '/meal-details';
  static const CATEGORIES_MEALS = '/categories-meals';
  static const HOME = '/';

  static void categoriesMealNavigate(
    final BuildContext context,
    final Category category,
  ) =>
      Navigator.of(context).pushNamed(
        CATEGORIES_MEALS,
        arguments: category,
      );

  static void mealDetailNavigate(
    final BuildContext context,
    final Meal meal,
  ) =>
      Navigator.of(context).pushNamed(
        MEAL_DETAIL,
        arguments: meal,
      );

  static final Map<String, WidgetBuilder> routes = {
    HOME: (_) => _homeScreen,
    CATEGORIES_MEALS: (_) => _categoriesMealScreeen,
    MEAL_DETAIL: (_) => _mealDetailScreen,
  };
}
