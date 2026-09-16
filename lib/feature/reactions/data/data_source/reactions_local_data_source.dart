import 'dart:convert';

import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/outbox/outbox_dao.dart';
import 'package:news_task/feature/reactions/data/model/params/enqueue_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/pending_reaction_model.dart';

abstract class ReactionsLocalDataSource {
  static const String op = 'set_reaction';

  Future<List<PendingReactionModel>> getPendingReactions();

  Future<void> enqueueReaction(EnqueueReactionParams params);

  Future<void> removePending(String articleId);
}

class ReactionsLocalDataSourceImp implements ReactionsLocalDataSource {
  ReactionsLocalDataSourceImp(this._dao);

  final OutboxDao _dao;

  @override
  Future<List<PendingReactionModel>> getPendingReactions() async {
    final entities = await _dao.getMutationsByOp(ReactionsLocalDataSource.op);
    return entities.map(PendingReactionModel.fromDB).toList();
  }

  @override
  Future<void> enqueueReaction(EnqueueReactionParams params) async {
    await _dao.deleteByArticleAndOp(
      params.articleId,
      ReactionsLocalDataSource.op,
    );
    await _dao.insertMutation(
      OutboxMutationsCompanion.insert(
        idempotencyKey: params.idempotencyKey,
        op: ReactionsLocalDataSource.op,
        articleId: params.articleId,
        payload: jsonEncode({
          'articleId': params.articleId,
          'reaction': params.reaction,
        }),
      ),
    );
  }

  @override
  Future<void> removePending(String articleId) =>
      _dao.deleteByArticleAndOp(articleId, ReactionsLocalDataSource.op);
}
