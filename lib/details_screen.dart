import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String recipeName;

  const DetailsScreen({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Details about $recipeName',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
