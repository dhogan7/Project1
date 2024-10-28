import 'package:flutter/material.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> favoriteRecipes = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>? ?? [];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 172, 9),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Favorite Recipes'),
      ),
      body: favoriteRecipes.isNotEmpty 
          ? ListView.builder(
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
                          groceryList: recipe['ingredients'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(child: Text('No favorite recipes found.')),
    );
  }
}