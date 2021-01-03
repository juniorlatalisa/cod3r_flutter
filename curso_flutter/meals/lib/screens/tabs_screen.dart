import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vamos cozinhar?'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.category),
                text: 'Categorias',
              ),
              Tab(
                icon: const Icon(Icons.star),
                text: 'Favoritos',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const CategoriesScreen(),
            const FavoriteScreen(),
          ],
        ),
      ),
    );
  }
}
