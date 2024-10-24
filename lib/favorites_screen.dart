import 'package:flutter/material.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<String> favoriteRecipes = const [
    'Spaghetti Carbonara',
    'Beef Stew',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteRecipes[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipeName: favoriteRecipes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
