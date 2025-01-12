import 'package:flutter/material.dart';
import 'appointment_page.dart';
import 'appointment.dart';

class HomePage extends StatefulWidget {
  final Appointment? appointment;

  const HomePage({Key? key, this.appointment}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Caffee'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: _selectedIndex == 0
            ? SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose your location',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildLocationCard(
                context,
                'Gutrud Fritz',
                'A cozy place for senior citizens to enjoy coffee with cats.',
                'assets/Seniorin.jpg',
                'Aachen',
                'Euphener Straße 2',
              ),
              const SizedBox(height: 10),
              _buildLocationCard(
                context,
                'Katzen Kaffe Aachen',
                'A popular cat cafe in Aachen with a variety of drinks.',
                'assets/cat_caffee.jpg',
                'Köln',
                'Neumarkt 2-4',
              ),
            ],
          ),
        )
            : widget.appointment != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Reservation:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: ${widget.appointment!.place}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Cat: ${widget.appointment!.cat}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Date: ${widget.appointment!.startTime.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Time: ${widget.appointment!.startTime.toLocal().toString().split(' ')[1].substring(0, 5)} - ${widget.appointment!.endTime.toLocal().toString().split(' ')[1].substring(0, 5)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Drinks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.appointment!.drinks.map((drink) => Text(
              drink,
              style: const TextStyle(fontSize: 18),
            )).toList(),
          ],
        )
            : const Center(
          child: Text(
            'No reservations made yet.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointment',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, String title, String description, String imagePath, String location, String address) {
    return Card(
      child: Column(
        children: [
          Image.asset(imagePath),
          ListTile(
            title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text(description),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentPage(
                        location: location,
                        address: address,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Book Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}