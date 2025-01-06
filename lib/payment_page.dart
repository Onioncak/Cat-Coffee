import 'package:flutter/material.dart';
import 'invoice_page.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, int> selectedItems;

  const PaymentPage({ required this.selectedItems}) ;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    // Berechne die Gesamtsumme der Bestellung
    totalAmount = widget.selectedItems.entries.fold(0.0, (sum, entry) {
      final price = _getPrice(entry.key);
      return sum + (price * entry.value);
    });
  }

  // Funktion, um den Preis für jedes Produkt zu erhalten
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

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Please select a payment method before completing the payment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Schließt den Dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedProducts = widget.selectedItems.entries
        .where((entry) => entry.value > 0)
        .toList();

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
                  final price = _getPrice(item.key);
                  return ListTile(
                    title: Text(item.key),
                    trailing: Text('x${item.value}  ${(_getPrice(item.key) * item.value).toStringAsFixed(2)} €'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Divider(), // Trennlinie vor der Total-Anzeige
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(2)}€',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Choose Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPaymentMethodIcon('icons_cash.png', 'Cash'),
                _buildPaymentMethodIcon('icons_paypal.png', 'PayPal'),
                _buildPaymentMethodIcon('icons_credit_card.png', 'Credit Card'),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPaymentMethod != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvoicePage(
                          selectedItems: widget.selectedItems,
                          totalAmount: totalAmount,
                          paymentMethod: selectedPaymentMethod!,
                        ),
                      ),
                    );
                  } else {
                    _showWarningDialog(); // Zeige Warnung, wenn keine Zahlungsmethode ausgewählt wurde
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                child: Text(
                  '  Complete Payment  ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodIcon(String iconName, String paymentMethod) {
    bool isSelected = selectedPaymentMethod == paymentMethod;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/Icons/$iconName',
                width: 50,
                height: 50,
              ),
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(paymentMethod),
        ],
      ),
    );
  }
}
