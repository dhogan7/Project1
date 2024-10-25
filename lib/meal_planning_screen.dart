import 'package:flutter/material.dart';

class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  _MealPlanningScreenState createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  final List<String> daysOfWeek = const [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];

  int currentDayIndex = 0;

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meals saved!')),
    );
  }

  void _navigateToNextDay() {
    if (currentDayIndex < daysOfWeek.length - 1) {
      setState(() {
        currentDayIndex++;
      });
      _saveMeals();
    }
  }

  void _navigateToPreviousDay() {
    if (currentDayIndex > 0) {
      setState(() {
        currentDayIndex--;
      });
      _saveMeals();
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDay = daysOfWeek[currentDayIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planning - $currentDay'),
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
              child: MealDayCard(
                day: currentDay,
                selectedMeals: selectedMeals[currentDay]!,
                onMealSelected: (mealType, recipe) {
                  setState(() {
                    selectedMeals[currentDay]![mealType] = recipe;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _navigateToPreviousDay,
                  child: const Text('Previous Day'),
                ),
                ElevatedButton(
                  onPressed: _navigateToNextDay,
                  child: const Text('Next Day'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MealDayCard extends StatelessWidget {
  final String day;
  final Map<String, String?> selectedMeals;
  final Function(String mealType, String recipe) onMealSelected;

  const MealDayCard({
    super.key,
    required this.day,
    required this.selectedMeals,
    required this.onMealSelected,
  });

  void _selectMeal(BuildContext context, String mealType) async {
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
      onMealSelected(mealType, selectedRecipe);
    }
  }

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
              day,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Breakfast:'),
            Text(selectedMeals['Breakfast'] ?? 'None', style: const TextStyle(fontSize: 16)),
            if (selectedMeals['Breakfast'] == null) 
              ElevatedButton(
                onPressed: () => _selectMeal(context, 'Breakfast'),
                child: const Text('Select Breakfast Recipe'),
              ),
            const SizedBox(height: 10),
            const Text('Lunch:'),
            Text(selectedMeals['Lunch'] ?? 'None', style: const TextStyle(fontSize: 16)),
            if (selectedMeals['Lunch'] == null) 
              ElevatedButton(
                onPressed: () => _selectMeal(context, 'Lunch'),
                child: const Text('Select Lunch Recipe'),
              ),
            const SizedBox(height: 10),
            const Text('Dinner:'),
            Text(selectedMeals['Dinner'] ?? 'None', style: const TextStyle(fontSize: 16)),
            if (selectedMeals['Dinner'] == null) 
              ElevatedButton(
                onPressed: () => _selectMeal(context, 'Dinner'),
                child: const Text('Select Dinner Recipe'),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}