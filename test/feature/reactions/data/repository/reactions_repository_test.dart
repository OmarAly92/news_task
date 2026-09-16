import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/reactions/data/model/params/enqueue_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/params/set_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/reaction_result_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';
import 'package:news_task/feature/reactions/data/repository/reactions_repository.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.dart';
import '../../../../helpers/result_matchers.dart';

void main() {
  late ReactionsRepositoryImp repository;
  late MockReactionsRemoteDataSource remote;
  late MockReactionsLocalDataSource local;
  late MockNetworkStatus network;

  setUpAll(() {
    registerFallbackValue(
      const SetReactionParams(
        articleId: 'x',
        reaction: 'like',
        clientMutationId: 'k',
      ),
    );
    registerFallbackValue(
      const EnqueueReactionParams(
        articleId: 'x',
        reaction: 'like',
        idempotencyKey: 'k',
      ),
    );
    registerFallbackValue(const ReactionUpdateModel());
  });

  setUp(() {
    remote = MockReactionsRemoteDataSource();
    local = MockReactionsLocalDataSource();
    network = MockNetworkStatus();
    repository = ReactionsRepositoryImp(remote, local, network);
    when(() => local.enqueueReaction(any())).thenAnswer((_) async {});
    when(() => local.removePending(any())).thenAnswer((_) async {});
    when(() => local.saveServerState(any())).thenAnswer((_) async {});
  });

  group('setReaction', () {
    test('posts with a fresh idempotency key and expected version', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.setReaction(any())).thenAnswer(
        (_) async => const GlobalResponse(
          data: ReactionResultModel(status: 'success', likes: 11, version: 2),
        ),
      );

      final result = successValue(
        await repository.setReaction(
          articleId: 'a',
          like: true,
          expectedVersion: 1,
        ),
      );

      expect(result.isSuccess, isTrue);
      final params =
          verify(() => remote.setReaction(captureAny())).captured.single
              as SetReactionParams;
      expect(params.reaction, 'like');
      expect(params.expectedVersion, 1);
      expect(params.clientMutationId, isNotEmpty);
      verify(() => local.removePending('a')).called(1);
      final saved =
          verify(() => local.saveServerState(captureAny())).captured.single
              as ReactionUpdateModel;
      expect(saved.articleId, 'a');
      expect(saved.isLiked, isTrue);
      expect(saved.likes, 11);
      expect(saved.version, 2);
    });

    test('queues the reaction in the outbox when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);

      final result = successValue(
        await repository.setReaction(articleId: 'a', like: false),
      );

      expect(result.isQueued, isTrue);
      final params =
          verify(() => local.enqueueReaction(captureAny())).captured.single
              as EnqueueReactionParams;
      expect(params.reaction, 'unlike');
      verifyNever(() => remote.setReaction(any()));
    });

    test(
      'surfaces a conflict as a successful result carrying server state',
      () async {
        when(() => network.isConnected).thenAnswer((_) async => true);
        when(() => remote.setReaction(any())).thenAnswer(
          (_) async => GlobalResponse(
            data: ReactionResultModel.fromJson({
              'status': 'conflict',
              'serverState': {'isLiked': true, 'likes': 20, 'version': 5},
            }),
          ),
        );

        final result = successValue(
          await repository.setReaction(articleId: 'a', like: true),
        );

        expect(result.isConflict, isTrue);
        expect(result.serverState?.likes, 20);
        final saved =
            verify(() => local.saveServerState(captureAny())).captured.single
                as ReactionUpdateModel;
        expect(saved.articleId, 'a');
        expect(saved.isLiked, isTrue);
        expect(saved.likes, 20);
        expect(saved.version, 5);
      },
    );

    test('returns the failure when the request fails', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.setReaction(any())).thenThrow(serverFailure());

      final failure = failureValue(
        await repository.setReaction(articleId: 'a', like: true),
      );

      expect(failure.message, 'boom');
      verifyNever(() => local.enqueueReaction(any()));
    });
  });
}
