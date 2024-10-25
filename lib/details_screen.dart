import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String recipeName;
  final List<String> instructions;
  final List<String> groceryList;

  const DetailsScreen({
    super.key,
    required this.recipeName,
    required this.instructions,
    required this.groceryList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructions:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              for (var instruction in instructions) 
                Text('• $instruction', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Text(
                'Grocery List:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              for (var item in groceryList) 
                Text('• $item', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}