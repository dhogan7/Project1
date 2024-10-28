import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';

class RecipesScreen extends StatefulWidget {
  RecipesScreen({super.key});

  // Remove const to make the map mutable
  final Map<String, List<Map<String, dynamic>>> recipes = {
    'Breakfast': [
      {
        'name': 'Pancakes',
        'instructions': [
          'In a bowl, mix flour, sugar, baking powder, and salt.',
          'In another bowl, whisk together milk, eggs, and melted butter.',
          'Combine wet and dry ingredients until just mixed.',
          'Pour batter onto a hot griddle and cook until bubbles form, then flip and cook until golden brown.'
        ],
        'ingredients': [
          'Flour',
          'Sugar',
          'Baking powder',
          'Salt',
          'Milk',
          'Eggs',
          'Butter'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Omelette',
        'instructions': [
          'Whisk eggs with salt and pepper.',
          'Heat oil in a frying pan, pour in the eggs.',
          'Cook until edges firm up, then add cheese, vegetables, or meats of choice.',
          'Fold and serve when cooked through.'
        ],
        'ingredients': [
          'Eggs',
          'Salt',
          'Pepper',
          'Cheese',
          'Vegetables (e.g., bell peppers, onions)',
          'Cooking oil'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Avocado Toast',
        'instructions': [
          'Toast slices of bread.',
          'Mash avocado with salt and pepper.',
          'Spread avocado on toast and top with optional toppings like sliced tomatoes or poached eggs.'
        ],
        'ingredients': [
          'Bread',
          'Avocado',
          'Salt',
          'Pepper',
          'Optional toppings (e.g., tomatoes, poached eggs)'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Smoothie Bowl',
        'instructions': [
          'Blend your choice of fruits with yogurt and a splash of milk until smooth.',
          'Pour into a bowl and top with granola, nuts, and fresh fruits.'
        ],
        'ingredients': [
          'Assorted fruits (e.g., bananas, berries)',
          'Yogurt',
          'Milk',
          'Granola',
          'Nuts'
        ],
        'isFavorite': false,
      },
    ],
    'Lunch': [
      {
        'name': 'Chicken Fajitas',
        'instructions': [
          'Heat oil in a pan.',
          'Season chicken tenderloins with seasoning of choice.',
          'Add chicken tenderloins to pan and cook for 10-12 minutes.',
          'Add sliced bell peppers and onions to the pan.',
          'Let cool for 3-5 minutes and serve.'
        ],
        'ingredients': [
          'Chicken Tenderloins',
          'Bell Peppers',
          'Onions',
          'Cooking oil',
          'Seasoning of choice'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Greek Salad',
        'instructions': [
          'Chop vegetables.',
          'Mix all ingredients.',
          'Serve chilled.'
        ],
        'ingredients': [
          'Cucumbers',
          'Tomatoes',
          'Juice from Lemon',
          'Feta cheese'
        ],
        'isFavorite': false,
      },
    ],
    'Dinner': [
      {
        'name': 'Spaghetti Carbonara',
        'instructions': [
          'Cook spaghetti according to package instructions.',
          'In a bowl, mix eggs, cheese, and pepper.',
          'Drain pasta and mix with egg mixture off the heat.',
          'Serve immediately.'
        ],
        'ingredients': [
          'Spaghetti',
          'Eggs',
          'Pecorino Romano cheese',
          'Black pepper',
          'Pancetta'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Chicken Parmesan',
        'instructions': [
          'Bread chicken and fry until golden.',
          'Top with marinara sauce and cheese.',
          'Bake until cheese is melted.',
          'Serve with pasta.'
        ],
        'ingredients': [
          'Chicken breasts',
          'Bread crumbs',
          'Marinara sauce',
          'Mozzarella cheese',
          'Spaghetti'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Beef Stew',
        'instructions': [
          'Brown beef in a pot.',
          'Add onions, carrots, and potatoes.',
          'Pour in broth and simmer for 2 hours.',
          'Season and serve.'
        ],
        'ingredients': [
          'Beef',
          'Onions',
          'Carrots',
          'Potatoes',
          'Beef broth',
          'Seasonings'
        ],
        'isFavorite': false,
      },
      {
        'name': 'Vegetable Stir-fry',
        'instructions': [
          'Heat oil in a pan.',
          'Add vegetables and stir-fry for 5-7 minutes.',
          'Add soy sauce and serve with rice.'
        ],
        'ingredients': [
          'Mixed vegetables',
          'Soy sauce',
          'Rice',
          'Cooking oil'
        ],
        'isFavorite': false,
      },
    ],
  };

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  void _toggleFavorite(Map<String, dynamic> recipe) {
    setState(() {
      recipe['isFavorite'] = !recipe['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Recipe List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              final favoriteRecipes = widget.recipes.values
                  .expand((meal) => meal)
                  .where((recipe) => recipe['isFavorite'])
                  .toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                  settings: RouteSettings(arguments: favoriteRecipes),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: widget.recipes.entries.map((entry) {
          final mealType = entry.key;
          final mealRecipes = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  mealType,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ...mealRecipes.map((recipe) {
                return ListTile(
                  title: Text(recipe['name']),
                  trailing: IconButton(
                    icon: Icon(
                      recipe['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      color: recipe['isFavorite'] ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(recipe),
                  ),
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
              // ignore: unnecessary_to_list_in_spreads
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}