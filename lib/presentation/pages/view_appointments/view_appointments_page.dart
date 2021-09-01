import 'package:calendar_booking_app/data/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_bloc.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_event.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_state.dart';

///
class ViewAppointmentsPage extends StatelessWidget {
  ///
  const ViewAppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kReleaseMode
          ? Container()
          : FloatingActionButton.extended(
              onPressed: () async {
                await context.read<MyDatabase>().deleteAllAppointments;
              },
              label: const Text('Delete All'),
              icon: const Icon(Icons.delete),
            ),
      appBar: AppBar(
        title: const Text('View Appointments'),
      ),
      body: Center(
        child: BlocConsumer<AppointmentsBloc, AppointmentsState>(
          listener: (context, state) {
            if (state is AppointmentsLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loading Appointments...'),
                ),
              );
            } else if (state is AppointmentsLoadingErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not load Appointments'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AppointmentsLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is AppointmentsLoadingErrorState) {
              return TextButton.icon(
                onPressed: () {
                  context
                      .read<AppointmentsBloc>()
                      .add(const AppointmentsLoadEvent());
                },
                icon: const Icon(Icons.refresh),
                label: Text(state.error),
              );
            } else if (state is AppointmentsLoadingSuccessState) {
              return state.appointments.isEmpty
                  ? const Text('No Appointments')
                  : ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {},
                        title: Text('${state.appointments[index].firstName} '
                            '${state.appointments[index].lastName}'),
                        subtitle: Text('${state.appointments[index].email}, '
                            '${state.appointments[index].phone}'),
                        trailing: Text(
                          state.appointments[index].timing.substring(
                            0,
                            state.appointments[index].timing.length - 7,
                          ),
                        ),
                      ),
                      itemCount: state.appointments.length,
                    );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
