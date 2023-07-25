import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategorysMealsScreen extends StatelessWidget {
  final List<Meal> meal;

  const CategorysMealsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final categoryMeals = meal.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (_, index) {
          return MealItem(meal: categoryMeals[index]);
        },
      ),
    );
  }
}
