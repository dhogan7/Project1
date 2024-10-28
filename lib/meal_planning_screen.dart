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

  void _showIngredientsDialog(String day) {
    Map<String, String?> meals = selectedMeals[day]!;
    List<String> ingredientsList = [];

    meals.forEach((mealType, recipe) {
      if (recipe != null) {
        ingredientsList.add('$mealType:');
        ingredientsList.addAll(recipesIngredients[recipe]!.map((ingredient) => ' - $ingredient'));
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingredients'),
          content: SingleChildScrollView(
            child: ListBody(
              children: ingredientsList.isNotEmpty
                  ? ingredientsList.map((ingredient) => Text(ingredient)).toList()
                  : [const Text('No meals selected for this day.')],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
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
                onShowIngredients: () => _showIngredientsDialog(currentDay),
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

  final Map<String, List<String>> recipesIngredients = {
    'Spaghetti Carbonara': [
      'Spaghetti',
      'Eggs',
      'Parmesan cheese',
      'Pancetta',
      'Black pepper',
    ],
    'Chicken Parmesan': [
      'Chicken breasts',
      'Bread crumbs',
      'Parmesan cheese',
      'Marinara sauce',
      'Mozzarella cheese',
    ],
    'Beef Stew': [
      'Beef',
      'Carrots',
      'Potatoes',
      'Onions',
      'Beef broth',
    ],
    'Vegetable Stir-fry': [
      'Mixed vegetables',
      'Soy sauce',
      'Garlic',
      'Ginger',
      'Sesame oil',
    ],
    'Pancakes': [
      'Flour',
      'Milk',
      'Eggs',
      'Baking powder',
      'Butter',
    ],
    'Omelette': [
      'Eggs',
      'Cheese',
      'Bell peppers',
      'Onions',
      'Salt',
    ],
    'Avocado Toast': [
      'Bread',
      'Avocado',
      'Lemon juice',
      'Salt',
      'Pepper',
    ],
    'Smoothie Bowl': [
      'Frozen berries',
      'Banana',
      'Yogurt',
      'Granola',
      'Honey',
    ],
    'Chicken Fajitas': [
      'Chicken breasts',
      'Bell peppers',
      'Onions',
      'Fajita seasoning',
      'Tortillas',
    ],
  };
}

class MealDayCard extends StatelessWidget {
  final String day;
  final Map<String, String?> selectedMeals;
  final Function(String mealType, String recipe) onMealSelected;
  final VoidCallback onShowIngredients;

  const MealDayCard({
    super.key,
    required this.day,
    required this.selectedMeals,
    required this.onMealSelected,
    required this.onShowIngredients,
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
            ElevatedButton(
              onPressed: onShowIngredients,
              child: const Text('Show Ingredients'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}