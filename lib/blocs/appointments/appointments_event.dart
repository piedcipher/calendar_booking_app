import 'package:calendar_booking_app/data/database/database.dart';

/// Base class for AppointmentsEvent
abstract class AppointmentsEvent {
  /// Constructor
  const AppointmentsEvent();
}

/// event for loading appointments from database
class AppointmentsLoadEvent extends AppointmentsEvent {
  /// Constructor
  const AppointmentsLoadEvent();
}

/// event for dispatching appointments from database
class AppointmentsDispatchEvent extends AppointmentsEvent {
  /// Constructor
  const AppointmentsDispatchEvent(this.appointments);

  /// list of appointments from database
  final List<Appointment> appointments;
}

/// event for creating appointments in database
class AppointmentsCreateEvent extends AppointmentsEvent {
  /// Constructor
  const AppointmentsCreateEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.timing,
  });

  /// first name of the student
  final String firstName;

  /// last name of the student
  final String lastName;

  /// email of the student
  final String email;

  /// phone of the student
  final String phone;

  /// timing of the appointment
  final String timing;
}
