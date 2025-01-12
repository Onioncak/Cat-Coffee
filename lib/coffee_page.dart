import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_page.dart';

class coffee_page extends StatefulWidget {
  final String selectedTime;
  final String location;
  final String address;
  final DateTime selectedDate;
  final String selectedCat;

  coffee_page({
    required this.selectedTime,
    required this.location,
    required this.address,
    required this.selectedDate,
    required this.selectedCat,
  });

  @override
  _coffee_pageState createState() => _coffee_pageState();
}

class _coffee_pageState extends State<coffee_page> {
  final Map<String, int> _selectedDrinks = {
    'Espresso': 0,
    'Milk': 0,
    'Black Coffee': 0,
    'Cacao': 0,
    'Cappuccino': 0,
  };

  final Map<String, double> _drinkPrices = {
    'Espresso': 2.0,
    'Milk': 1.5,
    'Black Coffee': 2.5,
    'Cacao': 3.0,
    'Cappuccino': 4.0,
  };

  void _incrementDrink(String drink) {
    setState(() {
      _selectedDrinks[drink] = (_selectedDrinks[drink] ?? 0) + 1;
    });
  }

  void _decrementDrink(String drink) {
    setState(() {
      if (_selectedDrinks[drink]! > 0) {
        _selectedDrinks[drink] = (_selectedDrinks[drink] ?? 0) - 1;
      }
    });
  }

  void _goToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          selectedTime: widget.selectedTime,
          location: widget.location,
          address: widget.address,
          selectedDate: widget.selectedDate,
          selectedCat: widget.selectedCat,
          selectedDrinks: _selectedDrinks,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Drinks'),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: _selectedDrinks.keys.map((drink) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/${drink.toLowerCase().replaceAll(' ', '_')}.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drink,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_drinkPrices[drink]!.toStringAsFixed(2)} €',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => _decrementDrink(drink),
                  ),
                  Text(
                    '${_selectedDrinks[drink]}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _incrementDrink(drink),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _goToPayment,
          child: const Text('Proceed to Payment'),
        ),
      ),
    );
  }
}