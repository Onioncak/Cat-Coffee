class Appointment {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String place;
  final String cat;
  final List<String> drinks;

  Appointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.place,
    required this.cat,
    required this.drinks,
  });
}

class AppointmentService {
  final List<Appointment> _appointments = [];

  void saveAppointment(Appointment appointment) {
    _appointments.add(appointment);
  }

  List<Appointment> getAppointments() {
    return _appointments;
  }

  bool isTimeSlotAvailable(DateTime startTime, DateTime endTime, String place) {
    for (var appointment in _appointments) {
      if (appointment.place == place &&
          ((startTime.isBefore(appointment.endTime) &&
              startTime.isAfter(appointment.startTime)) ||
              (endTime.isBefore(appointment.endTime) &&
                  endTime.isAfter(appointment.startTime)) ||
              (startTime.isBefore(appointment.startTime) &&
                  endTime.isAfter(appointment.endTime)))) {
        return false;
      }
    }
    return true;
  }
}