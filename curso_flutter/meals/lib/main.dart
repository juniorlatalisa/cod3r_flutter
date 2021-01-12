import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screens.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _avaliableMeal = DUMMY_MEALS;

  void _filterMeals(Settings settings) {
    setState(() {
      _avaliableMeal = DUMMY_MEALS.where((meal) {
        final filterGlutem = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !(filterGlutem ||
            filterLactose ||
            filterVegan ||
            filterVegetarian);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          fontFamily: 'Raleway',
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ),
              )),
      // home: CategoriesScreen(),
      initialRoute: AppRoutes.HOME, //Opcional
      routes: {
        AppRoutes.HOME: (_) => TabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealScreeen(_avaliableMeal),
        AppRoutes.MEAL_DETAIL: (_) => const MealDetailScreen(),
        AppRoutes.SETTINGS: (_) => SettingsScreen(_filterMeals),
      },
      // onGenerateRoute: (settings) {    //Método chamado caso a rota não for
      //   if (settings.name == '/') {}   //encotrada em routes
      //   return null;                   //Permitir geração de rotas dinamicas
      // },
      // onUnknownRoute: (settings) {     //Método chamado caso a rota não for
      //   if (settings.name == '/') {}   //encontrada nem em routes e nem em
      //   return null;                   //onGenerateRoute
      // },                               //Exemplor: 404
    );
  }
}
