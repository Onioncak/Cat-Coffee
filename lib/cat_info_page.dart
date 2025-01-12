/*
import 'package:flutter/material.dart';
import 'coffee_page.dart';
import 'cat_page.dart'; // Importiere die Cat-Klasse

class CatInfoPage extends StatelessWidget {
  final Cat cat;

  const CatInfoPage({super.key,  required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                cat.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                cat.description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const coffee_page()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              child: const Text(
                'Order a drink',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */
