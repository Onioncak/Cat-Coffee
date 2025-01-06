import 'package:flutter/material.dart';
import 'cat_info_page.dart';


class CatPage extends StatelessWidget {
  final String selectedTime;

  const CatPage({ required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    final List<Cat> cats = [
      Cat(
        name: 'Cat 1',
        imagePath: 'assets/cat1.PNG',
        description: 'Cat 1 description',
      ),
      Cat(
        name: 'Cat 2',
        imagePath: 'assets/cat2.PNG',
        description: 'Cat 2 description',
      ),
      Cat(
        name: 'Cat 3',
        imagePath: 'assets/cat3.PNG',
        description: 'Cat 3 description',
      ),
      Cat(
        name: 'Cat 4',
        imagePath: 'assets/cat4.PNG',
        description: 'Cat 4 description',
      ),
      Cat(
        name: 'Cat 5',
        imagePath: 'assets/cat5.PNG',
        description: 'Cat 5 description',
      ),
      Cat(
        name: 'Cat 6',
        imagePath: 'assets/cat6.PNG',
        description: 'Cat 6 description',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Page'),
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
                  builder: (context) => CatInfoPage(cat: cat),
                ),
              );
            },
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
                SizedBox(height: 8),
                Text(
                  cat.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
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
