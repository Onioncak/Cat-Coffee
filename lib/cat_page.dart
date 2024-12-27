import 'package:flutter/material.dart';
import 'cat_info_page.dart';

class CatPage extends StatelessWidget {
  final String selectedTime;

  const CatPage({Key? key, required this.selectedTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cats = [
      {'image': 'assets/cat1.PNG', 'name': 'Cat 1'},
      {'image': 'assets/cat2.PNG', 'name': 'Cat 2'},
      {'image': 'assets/cat3.PNG', 'name': 'Cat 3'},
      {'image': 'assets/cat4.PNG', 'name': 'Cat 4'},
      {'image': 'assets/cat5.PNG', 'name': 'Cat 5'},
      {'image': 'assets/cat6.PNG', 'name': 'Cat 6'},
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
                  builder: (context) => CatInfoPage(
                    catName: cat['name']!,
                    imagePath: cat['image']!,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    cat['image']!,
                    fit: BoxFit.cover, // Bild wird proportional skaliert
                    width: double.infinity, // Die Bilder nehmen die gesamte Breite ein
                    height: 300, // Höhe erhöht auf 300 für größere Bilder
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  cat['name']!,
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
