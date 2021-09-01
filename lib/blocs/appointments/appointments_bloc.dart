import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor/moor.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_event.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_state.dart';
import 'package:calendar_booking_app/data/database/database.dart';

/// Bloc responsible for loading and creating appointments
class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  /// Constructs AppointmentsBloc
  AppointmentsBloc(this._myDatabase) : super(const AppointmentsInitialState());

  final MyDatabase _myDatabase;

  StreamSubscription? _streamSubscription;

  @override
  Stream<AppointmentsState> mapEventToState(AppointmentsEvent event) async* {
    if (event is AppointmentsLoadEvent) {
      yield* _mapAppointmentsLoadEventToState(event);
    } else if (event is AppointmentsCreateEvent) {
      yield* _mapAppointmentsCreateEventToState(event);
    } else if (event is AppointmentsDispatchEvent) {
      yield* _mapAppointmentsDispatchEventToState(event);
    }
  }

  Stream<AppointmentsState> _mapAppointmentsLoadEventToState(
      AppointmentsLoadEvent event) async* {
    await _streamSubscription?.cancel();
    try {
      yield const AppointmentsLoadingState();
      _streamSubscription =
          _myDatabase.watchAppointments.listen((appointments) {
        add(AppointmentsDispatchEvent(appointments));
      });
    } catch (e) {
      yield AppointmentsLoadingErrorState(e.toString());
    }
  }

  Stream<AppointmentsState> _mapAppointmentsCreateEventToState(
      AppointmentsCreateEvent event) async* {
    try {
      yield const AppointmentsCreateLoadingState();
      await _myDatabase.addAppointment(
        AppointmentsCompanion(
          firstName: Value<String>(event.firstName),
          lastName: Value<String>(event.lastName),
          email: Value<String>(event.email),
          phone: Value<String>(event.phone),
          timing: Value<String>(event.timing),
        ),
      );
      yield const AppointmentsCreateSuccessState();
    } catch (e) {
      yield AppointmentsCreateErrorState(e.toString());
    }
  }

  Stream<AppointmentsState> _mapAppointmentsDispatchEventToState(
      AppointmentsDispatchEvent event) async* {
    yield AppointmentsLoadingSuccessState(event.appointments);
  }
}
