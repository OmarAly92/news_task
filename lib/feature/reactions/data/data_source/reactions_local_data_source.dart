import 'dart:convert';

import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/articles/articles_dao.dart';
import 'package:news_task/core/database/tables/feed_items/feed_items_dao.dart';
import 'package:news_task/core/database/tables/outbox/outbox_dao.dart';
import 'package:news_task/feature/reactions/data/model/params/enqueue_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/pending_reaction_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';

abstract class ReactionsLocalDataSource {
  static const String op = 'set_reaction';

  Future<List<PendingReactionModel>> getPendingReactions();

  Future<void> enqueueReaction(EnqueueReactionParams params);

  Future<void> removePending(String articleId);

  Future<void> saveServerState(ReactionUpdateModel update);
}

class ReactionsLocalDataSourceImp implements ReactionsLocalDataSource {
  ReactionsLocalDataSourceImp(this._dao, this._articlesDao, this._feedItemsDao);

  final OutboxDao _dao;
  final ArticlesDao _articlesDao;
  final FeedItemsDao _feedItemsDao;

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

  @override
  Future<void> saveServerState(ReactionUpdateModel update) async {
    final articleId = update.articleId;
    final isLiked = update.isLiked;
    if (articleId == null || isLiked == null) return;
    var likes = update.likes;
    if (likes == null) {
      final cached = await _articlesDao.getArticle(articleId);
      if (cached != null && cached.isLiked != isLiked) {
        likes = (cached.likes ?? 0) + (isLiked ? 1 : -1);
      }
    }
    await _articlesDao.updateReaction(
      articleId,
      isLiked: isLiked,
      likes: likes,
      version: update.version,
    );
    await _feedItemsDao.updateReaction(
      articleId,
      isLiked: isLiked,
      likes: likes,
      version: update.version,
    );
  }
}
