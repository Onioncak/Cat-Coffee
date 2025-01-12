import 'package:flutter/material.dart';
import 'invoice_page.dart';

class PaymentPage extends StatefulWidget {
  final String selectedTime;
  final String location;
  final String address;
  final DateTime selectedDate;
  final String selectedCat;
  final Map<String, int> selectedDrinks;

  PaymentPage({
    required this.selectedTime,
    required this.location,
    required this.address,
    required this.selectedDate,
    required this.selectedCat,
    required this.selectedDrinks,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    totalAmount = widget.selectedDrinks.entries.fold(0.0, (sum, entry) {
      final price = _getPrice(entry.key);
      return sum + (price * entry.value);
    });
    totalAmount += 10.0; // Adding 10 euros charge for cat reservation
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

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text('Please select a payment method before completing the payment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _finalizePayment() {
    if (selectedPaymentMethod != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvoicePage(
            selectedTime: widget.selectedTime,
            location: widget.location,
            address: widget.address,
            selectedDate: widget.selectedDate,
            selectedCat: widget.selectedCat,
            selectedDrinks: widget.selectedDrinks,
            totalAmount: totalAmount,
            paymentMethod: selectedPaymentMethod!,
          ),
        ),
      );
    } else {
      _showWarningDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedProducts = widget.selectedDrinks.entries
        .where((entry) => entry.value > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Order:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedProducts.length + 1, // Adding 1 for the cat reservation
              itemBuilder: (context, index) {
                if (index < selectedProducts.length) {
                  final item = selectedProducts[index];
                  final price = _getPrice(item.key);
                  return ListTile(
                    title: Text(item.key),
                    trailing: Text('x${item.value}  ${(_getPrice(item.key) * item.value).toStringAsFixed(2)} €'),
                  );
                } else {
                  return ListTile(
                    title: Text('Cat reservation (${widget.selectedCat})'),
                    trailing: Text('x1  10.00 €'),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(2)}€',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
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
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _finalizePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                child: const Text(
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
                const Positioned(
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
          const SizedBox(height: 10),
          Text(paymentMethod),
        ],
      ),
    );
  }
}