import 'package:flutter/material.dart';
import 'recipes_screen.dart';
import 'cuisine_screen.dart';
import 'meal_planning_screen.dart'; // Import your Meal Planning screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('Delicioso'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipesScreen()),
                );
              },
              child: const Text('Recipes'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CuisineScreen()),
                );
              },
              child: const Text('Explore Cuisines'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MealPlanningScreen()),
                );
              },
              child: const Text('Meal Planning'),
            ),
            const Spacer(), // Pushes the following button to the bottom
          ],
        ),
      ),
    );
  }
}