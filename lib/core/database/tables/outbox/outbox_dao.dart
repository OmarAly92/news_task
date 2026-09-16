import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/outbox/outbox_table.dart';
import 'package:news_task/core/error_handling/drift_error_handler/drift_error_handler.dart';

part 'outbox_dao.g.dart';

@DriftAccessor(tables: [OutboxMutations])
class OutboxDao extends DatabaseAccessor<AppDatabase> with _$OutboxDaoMixin {
  OutboxDao(super.db);

  Future<List<OutboxEntity>> getAllMutations() =>
      (select(outboxMutations)..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get()
          .handleLocalFailure();

  Stream<List<OutboxEntity>> watchAllMutations() =>
      (select(outboxMutations)..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .watch()
          .handleLocalFailure();

  Future<List<OutboxEntity>> getMutationsByOp(String op) => (select(
    outboxMutations,
  )..where((t) => t.op.equals(op))).get().handleLocalFailure();

  Future<int> insertMutation(OutboxMutationsCompanion mutation) =>
      into(outboxMutations).insert(mutation).handleLocalFailure();

  Future<int> deleteByArticleAndOp(String articleId, String op) =>
      (delete(outboxMutations)
            ..where((t) => t.articleId.equals(articleId) & t.op.equals(op)))
          .go()
          .handleLocalFailure();

  Future<int> deleteByKey(String idempotencyKey) =>
      (delete(outboxMutations)
            ..where((t) => t.idempotencyKey.equals(idempotencyKey)))
          .go()
          .handleLocalFailure();

  Future<int> incrementAttempts(String idempotencyKey) => customUpdate(
    'UPDATE outbox_mutations SET attempts = attempts + 1 WHERE idempotency_key = ?',
    variables: [Variable.withString(idempotencyKey)],
    updates: {outboxMutations},
  ).handleLocalFailure();
}
