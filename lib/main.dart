import 'package:flutter/material.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/error_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'screens/categorys_meals_screen.dart';
import 'utils/app_routes.dart';
import 'screens/tabs_screen.dart';
import 'models/meal.dart';
import 'data/dummy.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterVegetarian &&
            !filterVegan &&
            !filterLactose;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        fontFamily: "Raleway",
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                color: Colors.white,
              ),
            ),
      ),
      routes: {
        AppRoutes.home: (_) => TabScreen(favoriteMeals: _favoriteMeals),
        AppRoutes.CATEGORY_MELS: (ctx) =>
            CategorysMealsScreen(meal: _availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(
            onToggleFavorite: _toggleFavorite, isFavorite: isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(
              onSettingsChanged: _filterMeals,
              settings: settings,
            )
      },
      // Tela de Caso não encontre a página.
      // onGenerateRoute: (setting) {
      //   if (setting.name == "/alguma-coisa") {
      //     return null;
      //   } else {
      //     return MaterialPageRoute(
      //       builder: (_) => const CategoryScreen(),
      //     );
      //   }
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
        );
      },
    );
  }
}
