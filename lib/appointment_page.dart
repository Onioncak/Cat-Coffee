import 'package:flutter/material.dart';
import 'cat_page.dart';
import 'package:intl/intl.dart'; // Für Datumsformatierung

class AppointmentPage extends StatelessWidget {
     String location;
     String adress;

   AppointmentPage({ required this.location, required this.adress}) ;

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment in $location'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anzeige des aktuellen Datums
            Text(
              currentDate,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            // Anzeige der Straße
            Text(
              '$adress',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            // Verfügbare Zeiten als Matrix
            Text(
              'Available Times:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Anzahl der Spalten
                  crossAxisSpacing: 10, // Abstand zwischen den Spalten
                  mainAxisSpacing: 10, // Abstand zwischen den Zeilen
                ),
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatPage(selectedTime: availableTimes[index]),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      availableTimes[index],
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Liste der verfügbaren Zeiten
  final List<String> availableTimes = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];
}
