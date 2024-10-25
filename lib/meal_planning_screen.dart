import 'package:flutter/material.dart';

class MealPlanningScreen extends StatelessWidget {
  const MealPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plan your meals for the week!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  for (var day in daysOfWeek) MealDayCard(day: day),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List of days of the week
  final List<String> daysOfWeek = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
}

class MealDayCard extends StatelessWidget {
  final String day;

  const MealDayCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Breakfast:'),
            MealSelectionButton(mealType: 'Breakfast'),
            const SizedBox(height: 10),
            const Text('Lunch:'),
            MealSelectionButton(mealType: 'Lunch'),
            const SizedBox(height: 10),
            const Text('Dinner:'),
            MealSelectionButton(mealType: 'Dinner'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class MealSelectionButton extends StatelessWidget {
  final String mealType;

  const MealSelectionButton({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showRecipeDialog(context, mealType);
      },
      child: Text('Select $mealType Recipe'),
    );
  }

  void _showRecipeDialog(BuildContext context, String mealType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a $mealType Recipe'),
          content: SizedBox(
            width: double.minPositive,
            child: ListView(
              children: availableRecipes.map((recipe) {
                return ListTile(
                  title: Text(recipe),
                  onTap: () {
                    Navigator.pop(context, recipe);
                    // Here you can handle the selected recipe
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$recipe selected for $mealType')),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Sample available recipes
  final List<String> availableRecipes = const [
    'Spaghetti Carbonara',
    'Chicken Parmesan',
    'Beef Stew',
    'Vegetable Stir-fry',
    'Pancakes',
    'Omelette',
    'Avocado Toast',
    'Smoothie Bowl',
    'Chicken Fajitas',
  ];
}