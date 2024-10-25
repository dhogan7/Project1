import 'package:flutter/material.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<Map<String, dynamic>> favoriteRecipes = const [
    {
      'name': 'Spaghetti Carbonara',
      'instructions': [
        'Cook spaghetti according to package instructions.',
        'In a bowl, mix eggs, cheese, and pepper.',
        'Drain pasta and mix with egg mixture off the heat.',
        'Serve immediately.'
      ],
      'groceryList': [
        'Spaghetti',
        'Eggs',
        'Pecorino Romano cheese',
        'Black pepper',
        'Pancetta'
      ],
    },
    {
      'name': 'Beef Stew',
      'instructions': [
        'Brown beef in a pot.',
        'Add onions, carrots, and potatoes.',
        'Pour in broth and simmer for 2 hours.',
        'Season and serve.'
      ],
      'groceryList': [
        'Beef',
        'Onions',
        'Carrots',
        'Potatoes',
        'Beef broth',
        'Seasonings'
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 172, 9),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return ListTile(
            title: Text(recipe['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    recipeName: recipe['name'],
                    instructions: recipe['instructions'],
                    groceryList: recipe['groceryList'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}