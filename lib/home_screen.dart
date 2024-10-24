// home_screen.dart
import 'package:flutter/material.dart';
import 'recipes_screen.dart';
import 'favorites_screen.dart';
import 'cuisine_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add the Image widget here
            Image.asset(
              'assets/recipe_logo.png', // Replace with your image path
              height: 150, // Adjust height as needed
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipesScreen()),
                );
              },
              child: const Text('View Recipes'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                );
              },
              child: const Text('View Favorites'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CuisineScreen()),
                );
              },
              child: const Text('Explore Cuisines'),
            ),
          ],
        ),
      ),
    );
  }
}