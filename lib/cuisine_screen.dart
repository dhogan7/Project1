import 'package:flutter/material.dart';

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
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: const Text('Cuisines'),
        backgroundColor: Colors.redAccent,
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

  final Map<String, Map<String, Map<String, List<String>>>> cuisineRecipes = const {
    'Mediterranean': {
      'Greek Salad': {
        'summary': ['A refreshing salad made with cucumbers, tomatoes, and feta cheese.'],
        'instructions': ['Chop vegetables.', 'Mix all ingredients.', 'Serve chilled.'],
        'groceryList': ['Cucumbers', 'Tomatoes', 'Feta Cheese', 'Olive Oil', 'Lemon Juice'],
      },
      'Hummus': {
        'summary': ['A creamy dip made from blended chickpeas and tahini.'],
        'instructions': ['Blend chickpeas, tahini, and lemon juice.', 'Serve with pita.'],
        'groceryList': ['Chickpeas', 'Tahini', 'Lemon', 'Garlic', 'Olive Oil'],
      },
      // Add more recipes here...
    },
    'Mexican': {
      'Tacos': {
        'summary': ['Corn tortillas filled with meat, cheese, and fresh toppings.'],
        'instructions': ['Cook meat.', 'Fill tortillas.', 'Add toppings.'],
        'groceryList': ['Tortillas', 'Ground beef', 'Cheese', 'Lettuce', 'Tomatoes'],
      },
      'Enchiladas': {
        'summary': ['Rolled tortillas filled with meat and covered in sauce.'],
        'instructions': ['Fill tortillas with meat and cheese.', 'Roll and place in baking dish.', 'Cover with sauce and bake.'],
        'groceryList': ['Tortillas', 'Shredded chicken', 'Cheese', 'Enchilada sauce', 'Sour cream'],
      },
      
    },
    // Add other cuisines...
  };

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, List<String>>> recipes = cuisineRecipes[cuisine] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('$cuisine Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipeName = recipes.keys.elementAt(index);
          final summary = recipes[recipeName]?['summary']?.first ?? '';

          return ListTile(
            title: Text(recipeName),
            subtitle: Text(summary),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipeName: recipeName, details: recipes[recipeName]!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String recipeName;
  final Map<String, List<String>> details;

  const DetailsScreen({super.key, required this.recipeName, required this.details});

  @override
  Widget build(BuildContext context) {
    final instructions = details['instructions'] ?? [];
    final groceryList = details['groceryList'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Instructions:', style: Theme.of(context).textTheme.titleLarge),
            for (var instruction in instructions) 
              Text('• $instruction'),
            const SizedBox(height: 16),
            Text('Grocery List:', style: Theme.of(context).textTheme.titleLarge),
            for (var item in groceryList) 
              Text('• $item'),
          ],
        ),
      ),
    );
  }
}