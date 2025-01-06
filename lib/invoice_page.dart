import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_page.dart';

class InvoicePage extends StatelessWidget {
  final Map<String, int> selectedItems;
  final double totalAmount;
  final String paymentMethod;

  const InvoicePage({
    required this.selectedItems,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 150), // Abstand von oben
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bild in der Mitte
                Image.asset(
                  'assets/payment_success.png',
                  width: 200,
                  height: 200,
                ),
                // JSON-Animation direkt unter dem Bild
                Lottie.asset(
                  'assets/Animation - Payment.json',
                  width: 300,
                  height: 300,
                  repeat: false,
                ),
              ],
            ),
          ),
          // Button unten in der Mitte
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 50.0, // Abstand von unten
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false, // Entfernt alle vorherigen Routen
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                fixedSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                ' Thank You for Payment ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
