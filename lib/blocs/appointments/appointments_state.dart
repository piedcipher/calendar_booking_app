import 'package:calendar_booking_app/data/database/database.dart';

/// Base class for AppointmentsState
abstract class AppointmentsState {
  /// Constructor
  const AppointmentsState();
}

/// Default State
class AppointmentsInitialState extends AppointmentsState {
  /// Constructor
  const AppointmentsInitialState();
}

/// yield this when Appointments are being loaded from database
class AppointmentsLoadingState extends AppointmentsState {
  /// Constructor
  const AppointmentsLoadingState();
}

/// yield this when Appointments are successfully loaded from database
class AppointmentsLoadingSuccessState extends AppointmentsState {
  /// Constructor
  const AppointmentsLoadingSuccessState(this.appointments);

  /// appointments booked by students
  final List<Appointment> appointments;
}

/// yield this when Appointments are not loaded from database due to an error
class AppointmentsLoadingErrorState extends AppointmentsState {
  /// Constructor
  const AppointmentsLoadingErrorState(this.error);

  /// error message
  final String error;
}

/// yield this when Appointments are being created
class AppointmentsCreateLoadingState extends AppointmentsState {
  /// Constructor
  const AppointmentsCreateLoadingState();
}

/// yield this when Appointments are successfully created in database
class AppointmentsCreateSuccessState extends AppointmentsState {
  /// Constructor
  const AppointmentsCreateSuccessState();
}

/// yield this when Appointments are not created in database due to an error
class AppointmentsCreateErrorState extends AppointmentsState {
  /// Constructor
  const AppointmentsCreateErrorState(this.error);

  /// error message
  final String error;
}
