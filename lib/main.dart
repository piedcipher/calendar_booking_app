import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_bloc.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_event.dart';
import 'package:calendar_booking_app/data/database/database.dart';
import 'package:calendar_booking_app/core/bloc/bloc_observer.dart';
import 'package:calendar_booking_app/core/navigation/routes.dart';
import 'package:calendar_booking_app/core/themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = CalendarBookingAppBlocObserver();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MyDatabase(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppointmentsBloc>(
            create: (context) => AppointmentsBloc(context.read<MyDatabase>())
              ..add(const AppointmentsLoadEvent()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

/// Root Widget
class MyApp extends StatelessWidget {
  /// Constructs Root Widget
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      title: 'Calendar Booking App',
      initialRoute: Routes.homePage,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
