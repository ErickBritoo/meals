import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'favorite_screen.dart';
import '../components/drawer.dart';
import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabScreen({super.key, required this.favoriteMeals});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedScreenIndex = 0;
  late List<Map<String, Object>> _screens;

  void initState() {
    super.initState();
    _screens = [
      {
        "title": "Lista de Categorias",
        "screen": const CategoryScreen(),
      },
      {
        "title": "Meus Favoritos",
        "screen": FavoriteScreen(favoriteMeals: widget.favoriteMeals),
      }
    ];
  }

  _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${_screens[_selectedScreenIndex]["title"]}"),
        ),
        drawer: const MainDrawer(),
        body: _screens[_selectedScreenIndex]["screen"] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedScreenIndex,
          // type: BottomNavigationBarType.fixed,// Caso eu queira adicionar animação no TabBar
          onTap: _selectedScreen,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Categorias",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favoritos",
            ),
          ],
        ),
      ),
    );
  }
}
