import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screens = [
    CategoriesScreen(),
    FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text((_selectedScreenIndex == 0)
            ? 'Lista de Categorias'
            : 'Meus Favoritos'),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedScreenIndex = index),
        backgroundColor: theme.primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: theme.accentColor,
        currentIndex: _selectedScreenIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: 'Categorias',
            // title: Text('Categorias'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: 'Favoritos',
            // title: Text('Favoritos'),
          ),
        ],
      ),
      body: _screens[_selectedScreenIndex],
    );
    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Vamos cozinhar?'),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             icon: const Icon(Icons.category),
    //             text: 'Categorias',
    //           ),
    //           Tab(
    //             icon: const Icon(Icons.star),
    //             text: 'Favoritos',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: <Widget>[
    //         const CategoriesScreen(),
    //         const FavoriteScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
