import 'package:flutter/material.dart';
import 'coffee_page.dart';

class CatPage extends StatelessWidget {
  final String selectedTime;
  final String location;
  final String address;
  final DateTime selectedDate;

  CatPage({
    required this.selectedTime,
    required this.location,
    required this.address,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final List<Cat> cats = [
      Cat(
        name: 'Whiskers',
        imagePath: 'assets/cat1.PNG',
        description: 'Whiskers is a playful kitten who loves to chase laser pointers.',
      ),
      Cat(
        name: 'Mittens',
        imagePath: 'assets/cat2.PNG',
        description: 'Mittens enjoys lounging in the sun and napping all day.',
      ),
      Cat(
        name: 'Shadow',
        imagePath: 'assets/cat3.PNG',
        description: 'Shadow is a curious cat who loves to explore new places.',
      ),
      Cat(
        name: 'Luna',
        imagePath: 'assets/cat4.PNG',
        description: 'Luna is a friendly cat who loves to be around people.',
      ),
      Cat(
        name: 'Simba',
        imagePath: 'assets/cat5.PNG',
        description: 'Simba is a brave cat who loves to climb trees.',
      ),
      Cat(
        name: 'Bella',
        imagePath: 'assets/cat6.PNG',
        description: 'Bella is a gentle cat who loves to be petted.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Page'),
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: cats.length,
        itemBuilder: (context, index) {
          final cat = cats[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => coffee_page(
                    selectedTime: selectedTime,
                    location: location,
                    address: address,
                    selectedDate: selectedDate,
                    selectedCat: cat.name,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 8),
                Text(
                  cat.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  cat.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Cat {
  final String name;
  final String imagePath;
  final String description;

  Cat({required this.name, required this.imagePath, required this.description});
}