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
        'ingredients': ['Cucumbers', 'Tomatoes', 'Feta Cheese', 'Olive Oil', 'Juice from a lemon'],
      },
      'Hummus': {
        'summary': ['A creamy dip made from blended chickpeas and tahini.'],
        'instructions': ['Blend chickpeas, tahini, and lemon juice.', 'Serve with pita.'],
        'ingredients': ['Chickpeas', 'Tahini', 'Lemon', 'Garlic', 'Olive Oil'],
      },
    },
    'Mexican': {
      'Tacos': {
        'summary': ['Corn tortillas filled with meat, cheese, and fresh toppings.'],
        'instructions': ['Cook meat.', 'Fill tortillas.', 'Add toppings.'],
        'ingredients': ['Tortillas', 'Ground beef', 'Cheese', 'Lettuce', 'Tomatoes'],
      },
      'Enchiladas': {
        'summary': ['Rolled tortillas filled with meat and covered in sauce.'],
        'instructions': ['Fill tortillas with meat and cheese.', 'Roll and place in baking dish.', 'Cover with sauce and bake.'],
        'ingredients': ['Tortillas', 'Shredded chicken', 'Cheese', 'Enchilada sauce', 'Sour cream'],
      },
    },
    'Italian': {
      'Spaghetti Carbonara': {
        'summary': ['A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.'],
        'instructions': [
          'Cook spaghetti according to package instructions.',
          'In a bowl, mix eggs and cheese.',
          'Drain spaghetti and mix with egg mixture off the heat.',
          'Serve with additional cheese and pepper.'
        ],
        'ingredients': ['Spaghetti', 'Eggs', 'Pecorino Romano cheese', 'Pancetta', 'Black pepper'],
      },
      'Margherita Pizza': {
        'summary': ['A simple pizza topped with fresh tomatoes, mozzarella cheese, and basil.'],
        'instructions': [
          'Prepare pizza dough.',
          'Spread tomato sauce on the base.',
          'Add mozzarella slices and fresh basil.',
          'Bake until crust is golden and cheese is bubbly.'
        ],
        'ingredients': ['Pizza dough', 'Tomato sauce', 'Mozzarella cheese', 'Fresh basil', 'Olive oil'],
      },
    },
    'Asian': {
      'Vegetable Stir-fry': {
        'summary': ['A quick and healthy dish made with assorted vegetables stir-fried in soy sauce.'],
        'instructions': [
          'Heat oil in a pan.',
          'Add mixed vegetables and stir-fry for 5-7 minutes.',
          'Add soy sauce and serve with rice.'
        ],
        'ingredients': ['Mixed vegetables', 'Soy sauce', 'Rice', 'Cooking oil'],
      },
      'Chicken Teriyaki': {
        'summary': ['Grilled chicken glazed with a sweet soy sauce teriyaki.'],
        'instructions': [
          'Marinate chicken in teriyaki sauce for at least 30 minutes.',
          'Grill or pan-fry until cooked through.',
          'Serve with steamed rice and vegetables.'
        ],
        'ingredients': ['Chicken breasts', 'Teriyaki sauce', 'Rice', 'Steamed vegetables'],
      },
    },
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
    final groceryList = details['ingredients'] ?? [];

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
            Text('Ingredients:', style: Theme.of(context).textTheme.titleLarge),
            for (var item in groceryList) 
              Text('• $item'),
          ],
        ),
      ),
    );
  }
}