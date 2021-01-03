import 'package:flutter/material.dart';
import 'package:meals/utils/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      routes: AppRoutes.routes,
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
