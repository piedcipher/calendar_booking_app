import 'package:calendar_booking_app/core/navigation/routes.dart';
import 'package:flutter/material.dart';

/// Home-Page has options to select a user-type
class HomePage extends StatelessWidget {
  /// Constructs Home-Page
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue as ...'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.createAppointmentsPage,
                  );
                },
                child: const Text('Student'),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.viewAppointmentsPage,
                  );
                },
                child: const Text('Counsellor'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
