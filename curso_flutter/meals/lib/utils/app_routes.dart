import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class AppRoutes {
  static const MEAL_DETAIL = '/meal-details';
  static const CATEGORIES_MEALS = '/categories-meals';
  static const SETTINGS = '/settings';
  static const HOME = '/';

  static Future categoriesMealNavigate(
    final BuildContext context,
    final Category category,
  ) =>
      Navigator.of(context).pushNamed(
        CATEGORIES_MEALS,
        arguments: category,
      );

  static Future mealDetailNavigate(
    final BuildContext context,
    final Meal meal,
  ) =>
      Navigator.of(context).pushNamed(
        MEAL_DETAIL,
        arguments: meal,
      );

  static Future settingsNavigate(final BuildContext context) =>
      Navigator.of(context).pushNamed(
        SETTINGS,
        arguments: null,
      );
}
