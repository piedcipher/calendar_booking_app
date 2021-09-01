import 'package:calendar_booking_app/blocs/appointments/appointments_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_bloc.dart';
import 'package:calendar_booking_app/blocs/appointments/appointments_state.dart';

/// Page for creating appointments
class CreateAppointmentsPage extends StatefulWidget {
  /// Constructs Page for creating appointments
  const CreateAppointmentsPage({Key? key}) : super(key: key);

  @override
  _CreateAppointmentsPageState createState() => _CreateAppointmentsPageState();
}

class _CreateAppointmentsPageState extends State<CreateAppointmentsPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime _firstDay;

  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  final Map<String, bool> _timeSlots = {
    '09 - 10': false,
    '10 - 11': false,
    '11 - 12': false,
    '12 - 13': false,
    '13 - 14': false,
    '14 - 15': false,
    '15 - 16': false,
    '16 - 17': false,
  };

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime.now();
    if (_firstDay.weekday == 2) {
      _firstDay = _firstDay.add(const Duration(days: 2));
    } else if (_firstDay.weekday == 3) {
      _firstDay = _firstDay.add(const Duration(days: 1));
    }
    _focusedDay = _firstDay;
    _selectedDay = _firstDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Appointments'),
      ),
      body: Center(
        child: BlocConsumer<AppointmentsBloc, AppointmentsState>(
          listenWhen: (prev, current) => prev != current,
          listener: (context, state) async {},
          builder: (context, state) {
            if (state is AppointmentsLoadingSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TableCalendar<void>(
                      firstDay: _firstDay,
                      lastDay: _firstDay.add(const Duration(days: 365)),
                      focusedDay: _focusedDay,
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      selectedDayPredicate: (dateTime) {
                        return isSameDay(_selectedDay, dateTime);
                      },
                      enabledDayPredicate: (dateTime) {
                        return ![2, 3].contains(dateTime.weekday);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(thickness: 2),
                    const SizedBox(height: 5),
                    Column(
                      children: _timeSlots.keys
                          .map(
                            (e) => CheckboxListTile(
                              value: _timeSlots[e],
                              title: Text(e),
                              onChanged: state.appointments
                                      .where(
                                        (e) => isSameDay(
                                          _selectedDay,
                                          DateTime.tryParse(e.timing),
                                        ),
                                      )
                                      .map((e) => DateTime.parse(e.timing).hour)
                                      .toList()
                                      .contains(
                                          int.parse(e.split('-')[0].trim()))
                                  ? null
                                  : (timeSlotVal) {
                                      if (_selectedDay.isAfter(
                                        DateTime(
                                          _selectedDay.year,
                                          _selectedDay.month,
                                          _selectedDay.day,
                                          int.tryParse(e.split('-')[0].trim())!,
                                        ),
                                      )) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Time has passed, '
                                              'Can not book that slot',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      setState(() {
                                        _timeSlots[e] = timeSlotVal!;
                                      });
                                    },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 5),
                    const Divider(thickness: 2),
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _firstName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'First Name is required';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                                labelText: 'First Name',
                              ),
                            ),
                            const SizedBox(height: 2.5),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Last Name is required';
                                }
                                return null;
                              },
                              controller: _lastName,
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                              ),
                            ),
                            const SizedBox(height: 2.5),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                              controller: _email,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 2.5),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone is required';
                                }
                                return null;
                              },
                              controller: _phone,
                              decoration: const InputDecoration(
                                hintText: 'Phone',
                                labelText: 'Phone',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_timeSlots.values.contains(true)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Time Slot is required'),
                                      ),
                                    );
                                    return;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    _timeSlots.keys
                                        .where((e) => _timeSlots[e]!)
                                        .forEach((e) {
                                      final _timing = DateTime(
                                        _selectedDay.year,
                                        _selectedDay.month,
                                        _selectedDay.day,
                                        int.tryParse(e.split('-')[0].trim())!,
                                      );
                                      if (_selectedDay.isAfter(_timing)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Time has passed, '
                                              'Can not book that slot',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      context.read<AppointmentsBloc>().add(
                                            AppointmentsCreateEvent(
                                              firstName: _firstName.text,
                                              lastName: _lastName.text,
                                              email: _email.text,
                                              phone: _phone.text,
                                              timing: _timing.toString(),
                                            ),
                                          );
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Appointment Created'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Create Appointment'),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
