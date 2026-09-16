import 'dart:convert';

import 'package:news_task/core/database/tables/outbox/outbox_dao.dart';
import 'package:news_task/core/helpers/cache/cache_helper.dart';
import 'package:news_task/feature/sync/data/model/sync_mutation_model.dart';

abstract class SyncLocalDataSource {
  Future<List<SyncMutationModel>> getOutboxMutations();

  Stream<int> watchOutboxCount();

  Future<void> removeMutation(String idempotencyKey);

  Future<void> markAttempt(String idempotencyKey);

  int getBaseVersion();

  Future<void> saveBaseVersion(int version);
}

class SyncLocalDataSourceImp implements SyncLocalDataSource {
  SyncLocalDataSourceImp(this._dao);

  final OutboxDao _dao;

  @override
  Future<List<SyncMutationModel>> getOutboxMutations() async {
    final entities = await _dao.getAllMutations();
    return entities
        .map(
          (e) => SyncMutationModel(
            op: e.op,
            idempotencyKey: e.idempotencyKey,
            payload: (jsonDecode(e.payload) as Map).cast<String, dynamic>(),
          ),
        )
        .toList();
  }

  @override
  Stream<int> watchOutboxCount() =>
      _dao.watchAllMutations().map((rows) => rows.length);

  @override
  Future<void> removeMutation(String idempotencyKey) =>
      _dao.deleteByKey(idempotencyKey);

  @override
  Future<void> markAttempt(String idempotencyKey) =>
      _dao.incrementAttempts(idempotencyKey);

  @override
  int getBaseVersion() => CacheHelper.get(CacheKeys.syncVersion) as int? ?? 0;

  @override
  Future<void> saveBaseVersion(int version) =>
      CacheHelper.save(CacheKeys.syncVersion, version);
}
