import 'package:flutter/material.dart';
import 'details_screen.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  final List<String> recipes = const [
    'Spaghetti Carbonara',
    'Chicken Parmesan',
    'Beef Stew',
    'Vegetable Stir-fry'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
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
