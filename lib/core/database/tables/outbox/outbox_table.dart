import 'package:drift/drift.dart';

@DataClassName('OutboxEntity')
class OutboxMutations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idempotencyKey => text().unique()();
  TextColumn get op => text()();
  TextColumn get articleId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
}
