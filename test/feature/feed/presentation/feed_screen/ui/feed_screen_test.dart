import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/core/widgets/failure_widgets/app_error_widget.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/feed_updates_model.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_updates_params.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/feed_screen.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_article_card.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_skeleton_list.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';
import 'package:news_task/feature/sync/presentation/logic/sync_cubit.dart';

import '../../../../../helpers/fixtures.dart';
import '../../../../../helpers/mocks.dart';
import '../../../../../helpers/pump_app.dart';

void main() {
  late MockFeedRepository feedRepository;
  late MockBookmarksRepository bookmarksRepository;
  late MockReactionsRepository reactionsRepository;
  late MockSyncRepository syncRepository;
  late MockNetworkStatus networkStatus;
  late NetworkCubit networkCubit;
  late SyncCubit syncCubit;

  setUpAll(() async {
    await initLocalization();
    registerFallbackValue(const GetFeedParams());
    registerFallbackValue(const GetFeedUpdatesParams());
    registerFallbackValue(const ReactionUpdateModel());
  });

  setUp(() {
    feedRepository = MockFeedRepository();
    bookmarksRepository = MockBookmarksRepository();
    reactionsRepository = MockReactionsRepository();
    syncRepository = MockSyncRepository();
    networkStatus = MockNetworkStatus();
    when(() => networkStatus.isConnected).thenAnswer((_) async => true);
    when(
      () => networkStatus.onConnectivityChanged,
    ).thenAnswer((_) => const Stream.empty());
    when(() => syncRepository.pendingCount()).thenAnswer((_) async => 0);
    networkCubit = NetworkCubit(networkStatus);
    syncCubit = SyncCubit(syncRepository, networkCubit);
    when(
      () => bookmarksRepository.watchBookmarkedIds(),
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => reactionsRepository.updates,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => reactionsRepository.getPendingReactions(),
    ).thenAnswer((_) async => Result.success([]));
    when(
      () => feedRepository.getTopics(),
    ).thenAnswer((_) async => Result.success(topics));
    when(() => feedRepository.getFeedUpdates(any())).thenAnswer(
      (_) async => Result.success(
        const GlobalResponse(data: FeedUpdatesModel(deletedItems: [])),
      ),
    );
  });

  tearDown(() async {
    await syncCubit.close();
    await networkCubit.close();
  });

  Future<void> pumpFeed(WidgetTester tester, {double textScale = 1}) => pumpApp(
    tester,
    BlocProvider(
      create: (_) => FeedCubit(
        feedRepository,
        bookmarksRepository,
        reactionsRepository,
        networkCubit,
      ),
      child: const FeedScreen(),
    ),
    networkCubit: networkCubit,
    syncCubit: syncCubit,
    textScale: textScale,
  );

  testWidgets('shows the skeleton while loading, then the article cards', (
    tester,
  ) async {
    final completer =
        Completer<Result<GlobalResponse<FeedPageModel>, Failure>>();
    when(
      () => feedRepository.getFeed(any()),
    ).thenAnswer((_) => completer.future);

    await pumpFeed(tester);
    await tester.pump();

    expect(find.byType(FeedSkeletonList), findsOneWidget);
    expect(find.byType(FeedArticleCard), findsNothing);

    completer.complete(Result.success(response(feedPage(['a', 'b']))));
    await settle(tester);

    expect(find.byType(FeedSkeletonList), findsNothing);
    expect(find.byType(FeedArticleCard), findsWidgets);
    expect(find.text('Title a'), findsOneWidget);
  });

  testWidgets('shows the error state with retry, then recovers', (
    tester,
  ) async {
    var calls = 0;
    when(() => feedRepository.getFeed(any())).thenAnswer((_) async {
      calls++;
      return calls == 1
          ? Result.failure(serverFailure('Feed exploded'))
          : Result.success(response(feedPage(['a'])));
    });

    await pumpFeed(tester);
    await settle(tester);

    expect(find.byType(AppErrorWidget), findsOneWidget);
    expect(find.text('Feed exploded'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await settle(tester);

    expect(find.byType(AppErrorWidget), findsNothing);
    expect(find.byType(FeedArticleCard), findsOneWidget);
  });

  group('accessibility', () {
    testWidgets('exposes labelled, toggleable actions on each article card', (
      tester,
    ) async {
      when(
        () => feedRepository.getFeed(any()),
      ).thenAnswer((_) async => Result.success(response(feedPage(['a']))));
      final handle = tester.ensureSemantics();

      await pumpFeed(tester);
      await settle(tester);

      expect(find.bySemanticsLabel(RegExp(r'^Title a\.')), findsOneWidget);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Like')),
        matchesSemantics(
          label: 'Like',
          value: '10',
          isButton: true,
          hasToggledState: true,
          isToggled: false,
          isHidden: true,
        ),
      );
      expect(find.byTooltip('Save to bookmarks'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('comments')), findsOneWidget);
      expect(find.bySemanticsLabel('Theme'), findsOneWidget);
      expect(tester, meetsGuideline(androidTapTargetGuideline));
      expect(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });

    testWidgets('keeps the feed and its states laid out at 1.5x text scale', (
      tester,
    ) async {
      var calls = 0;
      when(() => feedRepository.getFeed(any())).thenAnswer((_) async {
        calls++;
        return calls == 1
            ? Result.failure(serverFailure('Feed exploded'))
            : Result.success(response(feedPage(['a', 'b', 'c'])));
      });

      await pumpFeed(tester, textScale: 1.5);
      await settle(tester);
      expect(find.byType(AppErrorWidget), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await settle(tester);
      expect(find.byType(FeedArticleCard), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}
