import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Observes operations of each bloc
class CalendarBookingAppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('BlocObserver onChange: ${bloc.runtimeType} $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('BlocObserver onEvent: ${bloc.runtimeType} $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('BlocObserver onError: ${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('BlocObserver onTransition: ${bloc.runtimeType} $transition');
  }
}
