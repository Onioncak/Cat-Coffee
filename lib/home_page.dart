import 'package:flutter/material.dart';
import 'appointment_page.dart';
import 'appointment.dart';
import 'invoice_page.dart';

class HomePage extends StatefulWidget {
  final Appointment? appointment;

  const HomePage({Key? key, this.appointment}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    if (widget.appointment != null) {
      _addAppointment(widget.appointment!);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addAppointment(Appointment appointment) {
    setState(() {
      _appointments.add(appointment);
    });
  }

  void _removeAppointment(Appointment appointment) {
    setState(() {
      _appointments.remove(appointment);
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
                'Eupener Straße 2',
              ),
              const SizedBox(height: 10),
              _buildLocationCard(
                context,
                'Cat Coffee Stolberg',
                'A popular cat cafe in Stolberg with a variety of drinks.',
                'assets/cat_caffee.jpg',
                'Stolberg',
                'Neumarkt 2-4',
              ),
            ],
          ),
        )
            : _appointments.isNotEmpty
            ? ListView.builder(
          itemCount: _appointments.length,
          itemBuilder: (context, index) {
            final appointment = _appointments[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Provider: ${appointment.place == 'Stolberg' ? 'Cat Coffee Stolberg' : 'Gutrud Fritz'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Location: ${appointment.place}, ${appointment.place == 'Stolberg' ? 'Neumarkt 2-4' : 'Eupener Straße 2'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Cat: ${appointment.cat}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Date: ${appointment.startTime.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Time: ${appointment.startTime.toLocal().toString().split(' ')[1].substring(0, 5)} - ${appointment.endTime.toLocal().toString().split(' ')[1].substring(0, 5)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Drinks:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...appointment.drinks.map((drink) => Text(
                      drink,
                      style: const TextStyle(fontSize: 18),
                    )).toList(),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _removeAppointment(appointment),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cancel Reservation'),
                    ),
                  ],
                ),
              ),
            );
          },
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