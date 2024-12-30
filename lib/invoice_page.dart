import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final Map<String, int> selectedItems;
  final double totalAmount;
  final String paymentMethod;

  const InvoicePage({
    Key? key,
    required this.selectedItems,
    required this.totalAmount,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedProducts = selectedItems.entries
        .where((entry) => entry.value > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Page'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  final item = selectedProducts[index];
                  final price = _getPrice(item.key);
                  return ListTile(
                    title: Text(item.key),
                    trailing: Text('x${item.value} - €${(price * item.value).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '€${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Payment Method: $paymentMethod',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  double _getPrice(String productName) {
    final prices = {
      'Black Coffee': 2.5,
      'Cacao': 3.0,
      'Cappuccino': 4.0,
      'Espresso': 2.0,
      'Milk': 1.5,
    };

    return prices[productName] ?? 0.0;
  }
}
