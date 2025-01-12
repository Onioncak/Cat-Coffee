import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cat_page.dart';
import 'appointment.dart';

class AppointmentPage extends StatefulWidget {
  final String location;
  final String address;

  AppointmentPage({super.key, required this.location, required this.address});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = _getNextWeekday(DateTime.now());
  }

  DateTime _getNextWeekday(DateTime date) {
    while (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      date = date.add(Duration(days: 1));
    }
    return date;
  }

  void _showDateMenu(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu<DateTime>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          overlay.localToGlobal(Offset.zero),
          overlay.localToGlobal(Offset(overlay.size.width, overlay.size.height)),
        ),
        Offset.zero & overlay.size,
      ),
      items: List<PopupMenuEntry<DateTime>>.generate(7, (int index) {
        DateTime date = _getNextWeekday(DateTime.now().add(Duration(days: index)));
        return PopupMenuItem<DateTime>(
          value: date,
          child: Text(DateFormat('EEEE, dd MMMM yyyy').format(date)),
        );
      }),
    ).then((DateTime? date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment in ${widget.location}'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _showDateMenu(context),
              child: Row(
                children: [
                  Text(
                    currentDate,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Display the address
            Text(
              widget.address,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            // Available times as a grid
            const Text(
              'Available Times:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 10, // Spacing between rows
                ),
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  final time = availableTimes[index];
                  final isAvailable = true; // Assume all times are available for simplicity

                  return ElevatedButton(
                    onPressed: isAvailable
                        ? () {
                      setState(() {
                        _selectedTime = time;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatPage(
                            selectedTime: _selectedTime!,
                            location: widget.location,
                            address: widget.address,
                            selectedDate: _selectedDate,
                          ),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAvailable ? Colors.brown : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      time,
                      style: const TextStyle(fontSize: 20),
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

  // List of available times
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