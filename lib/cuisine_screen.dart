import 'package:flutter/material.dart';
import 'details_screen.dart';

class CuisineScreen extends StatelessWidget {
  const CuisineScreen({super.key});

  final List<String> cuisines = const [
    'Mediterranean',
    'Mexican',
    'Gluten-Free',
    'Italian',
    'Asian'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuisines'),
      ),
      body: ListView.builder(
        itemCount: cuisines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cuisines[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListScreen(cuisine: cuisines[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  final String cuisine;

  const RecipeListScreen({super.key, required this.cuisine});

  final Map<String, List<String>> cuisineRecipes = const {
    'Mediterranean': ['Greek Salad', 'Hummus', 'Tabbouleh'],
    'Mexican': ['Tacos', 'Enchiladas', 'Guacamole'],
    'Gluten-Free': ['Quinoa Salad', 'Zucchini Noodles', 'Gluten-Free Pizza'],
    'Italian': ['Lasagna', 'Margherita Pizza', 'Risotto'],
    'Asian': ['Sushi', 'Pad Thai', 'Spring Rolls'],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> recipes = cuisineRecipes[cuisine] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$cuisine Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipeName: recipes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
