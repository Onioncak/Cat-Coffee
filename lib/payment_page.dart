import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final Map<String, int> selectedItems;

  const PaymentPage({Key? key, required this.selectedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedProducts = selectedItems.entries
        .where((entry) => entry.value > 0)
        .toList(); // Nur ausgewählte Artikel

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Order:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  final item = selectedProducts[index];
                  return ListTile(
                    title: Text(item.key),
                    trailing: Text('x${item.value}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Payment logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Complete Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
