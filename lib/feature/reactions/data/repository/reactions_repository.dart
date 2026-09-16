import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/reactions/data/data_source/reactions_local_data_source.dart';
import 'package:news_task/feature/reactions/data/data_source/reactions_remote_data_source.dart';
import 'package:news_task/feature/reactions/data/model/params/enqueue_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/params/set_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/pending_reaction_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_result_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';

abstract class ReactionsRepository {
  Stream<ReactionUpdateModel> get updates;

  FutureResult<ReactionResultModel> setReaction({
    required String articleId,
    required bool like,
    int? expectedVersion,
  });

  FutureResult<List<PendingReactionModel>> getPendingReactions();

  void publish(ReactionUpdateModel update);

  Future<void> saveServerState(ReactionUpdateModel update);
}

class ReactionsRepositoryImp implements ReactionsRepository {
  ReactionsRepositoryImp(
    this._remoteDataSource,
    this._localDataSource,
    this._network,
  );

  final ReactionsRemoteDataSource _remoteDataSource;
  final ReactionsLocalDataSource _localDataSource;
  final NetworkStatus _network;
  final StreamController<ReactionUpdateModel> _updates =
      StreamController.broadcast();
  final Uuid _uuid = const Uuid();

  @override
  Stream<ReactionUpdateModel> get updates => _updates.stream;

  @override
  void publish(ReactionUpdateModel update) => _updates.add(update);

  @override
  FutureResult<ReactionResultModel> setReaction({
    required String articleId,
    required bool like,
    int? expectedVersion,
  }) async {
    final reaction = like ? 'like' : 'unlike';
    final key = _uuid.v4();
    try {
      if (!await _network.isConnected) {
        await _localDataSource.enqueueReaction(
          EnqueueReactionParams(
            articleId: articleId,
            reaction: reaction,
            idempotencyKey: key,
          ),
        );
        return Result.success(
          ReactionResultModel(
            status: 'queued',
            articleId: articleId,
            reaction: reaction,
          ),
        );
      }
      final response = await _remoteDataSource.setReaction(
        SetReactionParams(
          articleId: articleId,
          reaction: reaction,
          clientMutationId: key,
          expectedVersion: expectedVersion,
        ),
      );
      await _localDataSource.removePending(articleId);
      final data = response.data ?? const ReactionResultModel();
      if (data.isSuccess) {
        await saveServerState(
          ReactionUpdateModel(
            articleId: articleId,
            isLiked: like,
            likes: data.likes,
            version: data.version,
          ),
        );
      } else if (data.isConflict) {
        await saveServerState(
          ReactionUpdateModel(
            articleId: articleId,
            isLiked: data.serverState?.isLiked,
            likes: data.serverState?.likes,
            version: data.serverState?.version,
          ),
        );
      }
      return Result.success(data);
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<void> saveServerState(ReactionUpdateModel update) =>
      _localDataSource.saveServerState(update);

  @override
  FutureResult<List<PendingReactionModel>> getPendingReactions() async {
    try {
      final result = await _localDataSource.getPendingReactions();
      return Result.success(result);
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }
}
