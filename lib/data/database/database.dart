import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Appointment Database Table
@DataClassName('Appointment')
class Appointments extends Table {
  /// appointment id for uniqueness
  IntColumn get id => integer().autoIncrement()();

  /// first name of the student
  TextColumn get firstName => text().named('first_name')();

  /// last name of the student
  TextColumn get lastName => text().named('last_name')();

  /// email of the student
  TextColumn get email => text()();

  /// phone of the student
  TextColumn get phone => text()();

  /// appointment date-time
  TextColumn get timing => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

/// App Database
@UseMoor(tables: [Appointments])
class MyDatabase extends _$MyDatabase {
  /// we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  /// stream of appointments
  Stream<List<Appointment>> get watchAppointments =>
      select(appointments).watch();

  /// add an appointment
  Future<int> addAppointment(AppointmentsCompanion entry) =>
      into(appointments).insert(entry);

  /// delete all appointments
  Future<int> get deleteAllAppointments => delete(appointments).go();

  /// bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 1;
}
