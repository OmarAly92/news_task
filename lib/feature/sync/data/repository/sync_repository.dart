import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_local_data_source.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';
import 'package:news_task/feature/reactions/data/repository/reactions_repository.dart';
import 'package:news_task/feature/sync/data/data_source/sync_local_data_source.dart';
import 'package:news_task/feature/sync/data/data_source/sync_remote_data_source.dart';
import 'package:news_task/feature/sync/data/model/params/sync_params.dart';
import 'package:news_task/feature/sync/data/model/sync_mutation_model.dart';
import 'package:news_task/feature/sync/data/model/sync_result_model.dart';

abstract class SyncRepository {
  Future<int> pendingCount();

  FutureResult<SyncResultModel?> sync();
}

class SyncRepositoryImp implements SyncRepository {
  SyncRepositoryImp(
    this._remoteDataSource,
    this._localDataSource,
    this._bookmarksLocalDataSource,
    this._reactionsRepository,
    this._network,
  );

  final SyncRemoteDataSource _remoteDataSource;
  final SyncLocalDataSource _localDataSource;
  final BookmarksLocalDataSource _bookmarksLocalDataSource;
  final ReactionsRepository _reactionsRepository;
  final NetworkStatus _network;

  @override
  Future<int> pendingCount() async {
    final mutations = await _collect();
    return mutations.length;
  }

  @override
  FutureResult<SyncResultModel?> sync() async {
    try {
      final mutations = await _collect();
      if (mutations.isEmpty) return Result.success(null);
      if (!await _network.isConnected) {
        return Result.failure(ServerFailure.noNetwork());
      }
      for (final mutation in mutations) {
        if (mutation.isReaction) {
          await _localDataSource.markAttempt(mutation.idempotencyKey!);
        }
      }
      final response = await _remoteDataSource.sync(
        SyncParams(
          baseVersion: _localDataSource.getBaseVersion(),
          mutations: mutations,
        ),
      );
      final result = response.data ?? const SyncResultModel();
      await _apply(mutations, result);
      return Result.success(result);
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }

  Future<List<SyncMutationModel>> _collect() async {
    final outbox = await _localDataSource.getOutboxMutations();
    final bookmarks = await _bookmarksLocalDataSource.getUnsyncedBookmarks();
    return [...outbox, ...bookmarks.map(_bookmarkMutation)];
  }

  SyncMutationModel _bookmarkMutation(BookmarkModel bookmark) {
    final removal = bookmark.pendingRemoval ?? false;
    final stamp = bookmark.savedAt?.millisecondsSinceEpoch ?? 0;
    return SyncMutationModel(
      op: 'set_bookmark',
      idempotencyKey:
          '${removal ? 'unbookmark' : 'bookmark'}:${bookmark.articleId}:$stamp',
      payload: {'articleId': bookmark.articleId, 'bookmarked': !removal},
    );
  }

  Future<void> _apply(
    List<SyncMutationModel> sent,
    SyncResultModel result,
  ) async {
    final applied = (result.applied ?? []).toSet();
    final conflicts = {
      for (final c in result.conflicts ?? [])
        if (c.idempotencyKey != null) c.idempotencyKey!: c,
    };
    for (final mutation in sent) {
      final key = mutation.idempotencyKey;
      final articleId = mutation.articleId;
      if (key == null || articleId == null) continue;
      final conflict = conflicts[key];
      if (!applied.contains(key) && conflict == null) continue;
      if (mutation.isReaction) {
        await _localDataSource.removeMutation(key);
        if (conflict != null) {
          _reactionsRepository.publish(
            ReactionUpdateModel(
              articleId: articleId,
              isLiked: conflict.isLiked,
              likes: conflict.serverLikes,
              version: conflict.version,
            ),
          );
        }
      } else if (mutation.isBookmark) {
        final bookmarked = mutation.payload?['bookmarked'] == true;
        if (bookmarked && conflict == null) {
          await _bookmarksLocalDataSource.markSynced(articleId);
        } else {
          await _bookmarksLocalDataSource.deleteBookmark(articleId);
        }
      }
    }
    final version = result.newVersion;
    if (version != null) await _localDataSource.saveBaseVersion(version);
  }
}
