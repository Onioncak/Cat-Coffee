import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'appointment.dart';
import 'package:lottie/lottie.dart';

class InvoicePage extends StatelessWidget {
  final String selectedTime;
  final String location;
  final String address;
  final DateTime selectedDate;
  final String selectedCat;
  final Map<String, int> selectedDrinks;
  final double totalAmount;
  final String paymentMethod;

  InvoicePage({
    required this.selectedTime,
    required this.location,
    required this.address,
    required this.selectedDate,
    required this.selectedCat,
    required this.selectedDrinks,
    required this.totalAmount,
    required this.paymentMethod,
  });

  Future<void> _saveReservation(BuildContext context) async {
    final DateTime startTime = DateTime.parse('${selectedDate.toIso8601String().split('T')[0]} $selectedTime:00');
    final DateTime endTime = startTime.add(Duration(minutes: 59));
    final List<String> selectedDrinksList = selectedDrinks.entries
        .where((entry) => entry.value > 0)
        .map((entry) => '${entry.key} x${entry.value}')
        .toList();
    final Appointment appointment = Appointment(
      id: DateTime.now().toString(),
      startTime: startTime,
      endTime: endTime,
      place: location,
      cat: selectedCat,
      drinks: selectedDrinksList,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastReservation', appointment.id);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage(appointment: appointment)),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Page'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation - Payment.json'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveReservation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}