import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'introductionPage/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;

  runApp(MyApp(hasSeenIntro: hasSeenIntro));
}

class MyApp extends StatelessWidget {
  final bool hasSeenIntro;

  const MyApp({super.key, required this.hasSeenIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasSeenIntro ? const HomePage() : IntroScreen(),
    );
  }
}

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _reservationController = TextEditingController();

  Future<void> _saveReservation(String reservation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reservation', reservation);
  }

  void _makeReservation() {
    final reservation = _reservationController.text;
    if (reservation.isNotEmpty) {
      _saveReservation(reservation);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reservation saved!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make a Reservation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reservationController,
              decoration: InputDecoration(labelText: 'Enter reservation details'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _makeReservation,
              child: Text('Save Reservation'),
            ),
          ],
        ),
      ),
    );
  }
}