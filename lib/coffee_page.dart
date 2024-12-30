import 'package:flutter/material.dart';
import 'payment_page.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  final Map<String, int> quantities = {
    'Black Coffee': 0,
    'Cacao': 0,
    'Cappuccino': 0,
    'Espresso': 0,
    'Milk': 0,
  };

  final Map<String, double> prices = {
    'Black Coffee': 2.5,
    'Cacao': 3.0,
    'Cappuccino': 4.0,
    'Espresso': 2.0,
    'Milk': 1.5,
  };

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> coffeeItems = [
      {'image': 'assets/black_coffee.JPG', 'name': 'Black Coffee'},
      {'image': 'assets/cacao.jpg', 'name': 'Cacao'},
      {'image': 'assets/capuccino.jpg', 'name': 'Cappuccino'},
      {'image': 'assets/espresso.jpg', 'name': 'Espresso'},
      {'image': 'assets/milk.jpg', 'name': 'Milk'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have a coffee?'),
            SizedBox(width: 8),
            Image.asset(
              'assets/Icons/icon-coffee-beans.png',
              width: 30,
              height: 30,
            ),
          ],
        ),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: coffeeItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Zwei Spalten
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 4, // Verhältnis der Breite zur Höhe
                ),
                itemBuilder: (context, index) {
                  final item = coffeeItems[index];
                  final name = item['name']!;
                  final imagePath = item['image']!;
                  final price = prices[name] ?? 0.0;

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            height: 100,
                            width: double.infinity,
                          ),
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${price.toStringAsFixed(2)} €',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantities[name]! > 0) {
                                    quantities[name] = quantities[name]! - 1;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                              color: Colors.brown,
                            ),
                            Text(
                              '${quantities[name]}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantities[name] = quantities[name]! + 1;
                                });
                              },
                              icon: Icon(Icons.add),
                              color: Colors.brown,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      selectedItems: quantities,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: Text(
                '  Proceed to Payment  ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
