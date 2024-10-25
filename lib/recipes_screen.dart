import 'package:flutter/material.dart';
import 'details_screen.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  final List<Map<String, dynamic>> recipes = const [
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
      'name': 'Chicken Parmesan',
      'instructions': [
        'Bread chicken and fry until golden.',
        'Top with marinara sauce and cheese.',
        'Bake until cheese is melted.',
        'Serve with pasta.'
      ],
      'groceryList': [
        'Chicken breasts',
        'Bread crumbs',
        'Marinara sauce',
        'Mozzarella cheese',
        'Spaghetti'
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
    {
      'name': 'Vegetable Stir-fry',
      'instructions': [
        'Heat oil in a pan.',
        'Add vegetables and stir-fry for 5-7 minutes.',
        'Add soy sauce and serve with rice.'
      ],
      'groceryList': [
        'Mixed vegetables',
        'Soy sauce',
        'Rice',
        'Cooking oil'
      ],
    },
    {
      'name': 'Chicken Fajitas',
      'instructions': [
        'Heat oil in a pan.',
        'Season chicken tenderloins with seasoning of choice.',
        'Add chicken tenderloins to pan and cook for 10-12 minutes.',
        'Add sliced bell peppers and onions to the pan.',
        'Let cool for 3-5 minutes and serve.'
      ],
      'groceryList': [
        'Chicken Tenderloins',
        'Bell Peppers',
        'Onions',
        'Cooking oil',
        'Seasoning of choice'
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Recipe List'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
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