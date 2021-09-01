import 'package:flutter/material.dart';
import 'package:calendar_booking_app/presentation/pages/home/home_page.dart';
import 'package:calendar_booking_app/presentation/pages/create_appointments/create_appointments_page.dart';
import 'package:calendar_booking_app/presentation/pages/view_appointments/view_appointments_page.dart';

/// Routes for Calendar Booking App
abstract class Routes {
  /// Home (initial) Page
  static const String homePage = '/';

  /// Create Appointments Page
  static const String createAppointmentsPage = '/create_appointments_page';

  /// View Appointments Page
  static const String viewAppointmentsPage = '/view_appointments_page';

  /// Route Generation
  static PageRoute onGenerateRoute(
    RouteSettings routeSettings,
  ) {
    switch (routeSettings.name) {
      case Routes.homePage:
        return MaterialPageRoute<void>(
          builder: (context) => const HomePage(),
        );

      case Routes.createAppointmentsPage:
        return MaterialPageRoute<void>(
          builder: (context) => const CreateAppointmentsPage(),
        );

      case Routes.viewAppointmentsPage:
        return MaterialPageRoute<void>(
          builder: (context) => const ViewAppointmentsPage(),
        );
    }

    return MaterialPageRoute<void>(
      builder: (context) => const Text('404 - Unknown Route'),
    );
  }
}
