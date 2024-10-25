import 'package:flutter/material.dart';

class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  _MealPlanningScreenState createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  // This will hold the selected meals for each day
  final Map<String, Map<String, String?>> selectedMeals = {
    'Monday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
    'Tuesday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
    'Wednesday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
    'Thursday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
    'Friday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
    'Saturday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
    'Sunday': {'Breakfast': null, 'Lunch': null, 'Dinner': null},
  };

  void _saveMeals() {
    // Here you would handle saving the meals, e.g., to a database or local storage
    // For demonstration, we'll show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meals saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planning'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveMeals,
          ),
        ],
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
                  for (var day in daysOfWeek) MealDayCard(
                    day: day,
                    onMealSelected: (mealType, recipe) {
                      setState(() {
                        selectedMeals[day]![mealType] = recipe;
                      });
                    },
                  ),
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

class MealDayCard extends StatefulWidget {
  final String day;
  final Function(String mealType, String recipe) onMealSelected;

  const MealDayCard({super.key, required this.day, required this.onMealSelected});

  @override
  _MealDayCardState createState() => _MealDayCardState();
}

class _MealDayCardState extends State<MealDayCard> {
  String? breakfast;
  String? lunch;
  String? dinner;

  void _selectMeal(String mealType) async {
    final selectedRecipe = await showDialog<String>(
      context: context,
      builder: (context) {
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

    if (selectedRecipe != null) {
      setState(() {
        if (mealType == 'Breakfast') {
          breakfast = selectedRecipe;
        } else if (mealType == 'Lunch') {
          lunch = selectedRecipe;
        } else if (mealType == 'Dinner') {
          dinner = selectedRecipe;
        }
        // Notify the parent widget about the selected meal
        widget.onMealSelected(mealType, selectedRecipe);
      });
    }
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
              widget.day,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Breakfast:'),
            Text(breakfast ?? 'None', style: const TextStyle(fontSize: 16)),
            ElevatedButton(
              onPressed: () => _selectMeal('Breakfast'),
              child: const Text('Select Breakfast Recipe'),
            ),
            const SizedBox(height: 10),
            const Text('Lunch:'),
            Text(lunch ?? 'None', style: const TextStyle(fontSize: 16)),
            ElevatedButton(
              onPressed: () => _selectMeal('Lunch'),
              child: const Text('Select Lunch Recipe'),
            ),
            const SizedBox(height: 10),
            const Text('Dinner:'),
            Text(dinner ?? 'None', style: const TextStyle(fontSize: 16)),
            ElevatedButton(
              onPressed: () => _selectMeal('Dinner'),
              child: const Text('Select Dinner Recipe'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}