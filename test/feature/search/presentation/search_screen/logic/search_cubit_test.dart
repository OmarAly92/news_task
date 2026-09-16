import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/search/data/model/params/get_suggestions_params.dart';
import 'package:news_task/feature/search/data/model/params/search_articles_params.dart';
import 'package:news_task/feature/search/data/model/search_page_model.dart';
import 'package:news_task/feature/search/data/model/suggestions_model.dart';
import 'package:news_task/feature/search/data/model/trending_model.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

import '../../../../../helpers/cubit_recorder.dart';
import '../../../../../helpers/fixtures.dart';
import '../../../../../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSearchRepository searchRepository;
  late MockFeedRepository feedRepository;

  setUpAll(() {
    registerFallbackValue(const SearchArticlesParams(query: 'q'));
    registerFallbackValue(const GetSuggestionsParams(query: 'q'));
  });

  setUp(() {
    searchRepository = MockSearchRepository();
    feedRepository = MockFeedRepository();
    when(
      () => feedRepository.getTopics(),
    ).thenAnswer((_) async => Result.success(topics));
    when(() => searchRepository.getSources()).thenAnswer(
      (_) async => Result.success({
        't_technology': ['TechWire'],
        't_sports': ['Match Point'],
      }),
    );
    when(() => searchRepository.getTrending()).thenAnswer(
      (_) async => Result.success(const GlobalResponse(data: TrendingModel())),
    );
    when(() => searchRepository.getSuggestions(any())).thenAnswer(
      (_) async => Result.success(
        const GlobalResponse(data: SuggestionsModel(suggestions: [])),
      ),
    );
    when(
      () => searchRepository.searchArticles(any()),
    ).thenAnswer((_) async => Result.success(response(searchPage(['a']))));
  });

  SearchCubit build() => SearchCubit(searchRepository, feedRepository);

  group('onQueryChanged', () {
    test('debounces keystrokes into a single search', () {
      fakeAsync((async) {
        final cubit = build();
        async.flushMicrotasks();

        cubit.onQueryChanged('f');
        cubit.onQueryChanged('fl');
        cubit.onQueryChanged('flu');
        async.elapse(const Duration(milliseconds: 200));
        cubit.onQueryChanged('flut');
        async.elapse(const Duration(milliseconds: 399));

        verifyNever(() => searchRepository.searchArticles(any()));

        async.elapse(const Duration(milliseconds: 1));
        async.flushMicrotasks();

        final params =
            verify(
                  () => searchRepository.searchArticles(captureAny()),
                ).captured.single
                as SearchArticlesParams;
        expect(params.query, 'flut');
        expect(cubit.results.map((r) => r.id), ['a']);
        cubit.close();
      });
    });

    test('does not search queries shorter than the minimum length', () {
      fakeAsync((async) {
        final cubit = build();
        async.flushMicrotasks();

        cubit.onQueryChanged('f');
        async.elapse(const Duration(seconds: 1));

        verifyNever(() => searchRepository.searchArticles(any()));
        cubit.close();
      });
    });

    test('clears results when the query is emptied', () {
      fakeAsync((async) {
        final cubit = build();
        async.flushMicrotasks();
        cubit.onQueryChanged('flutter');
        async.elapse(SearchCubit.debounceDuration);
        async.flushMicrotasks();
        expect(cubit.results, isNotEmpty);

        cubit.onQueryChanged('');
        async.flushMicrotasks();

        expect(cubit.results, isEmpty);
        expect(cubit.hasQuery, isFalse);
        cubit.close();
      });
    });
  });

  group('search', () {
    test('ignores a stale response that arrives after a newer query', () async {
      final slow =
          Completer<Result<GlobalResponse<SearchPageModel>, Failure>>();
      when(
        () => searchRepository.searchArticles(
          any(that: predicate<SearchArticlesParams>((p) => p.query == 'old')),
        ),
      ).thenAnswer((_) => slow.future);
      when(
        () => searchRepository.searchArticles(
          any(that: predicate<SearchArticlesParams>((p) => p.query == 'new')),
        ),
      ).thenAnswer((_) async => Result.success(response(searchPage(['new']))));
      final cubit = build();
      await flushMicrotasks();

      cubit.applyQuery('old');
      cubit.applyQuery('new');
      await flushMicrotasks();
      slow.complete(Result.success(response(searchPage(['old']))));
      await flushMicrotasks();

      expect(cubit.results.map((r) => r.id), ['new']);
      expect(cubit.state, const SearchSuccessState());
      await cubit.close();
    });

    test('re-runs the search with the active filters preserved', () async {
      final cubit = build();
      await flushMicrotasks();
      cubit.applyQuery('flutter');
      await flushMicrotasks();

      cubit.selectTopic('t_technology');
      await flushMicrotasks();
      cubit.selectSource('TechWire');
      await flushMicrotasks();
      cubit.selectDateRange(
        DateTimeRange(start: DateTime(2026, 9, 1), end: DateTime(2026, 9, 14)),
      );
      await flushMicrotasks();

      final params =
          verify(
                () => searchRepository.searchArticles(captureAny()),
              ).captured.last
              as SearchArticlesParams;
      expect(params.query, 'flutter');
      expect(params.topicId, 't_technology');
      expect(params.source, 'TechWire');
      expect(params.from, DateTime(2026, 9, 1));
      expect(cubit.activeFilterCount, 3);
      await cubit.close();
    });

    test(
      'drops a source that does not belong to the newly selected topic',
      () async {
        final cubit = build();
        await flushMicrotasks();
        cubit.selectTopic('t_technology');
        cubit.selectSource('TechWire');

        cubit.selectTopic('t_sports');

        expect(cubit.selectedSource, isNull);
        expect(cubit.availableSources, ['Match Point']);
        await cubit.close();
      },
    );

    test('emits failure state when the search fails', () async {
      when(
        () => searchRepository.searchArticles(any()),
      ).thenAnswer((_) async => Result.failure(serverFailure()));
      final cubit = build();
      await flushMicrotasks();
      final recorder = CubitRecorder(cubit);

      cubit.applyQuery('flutter');
      await flushMicrotasks();

      expect(recorder.states, contains(isA<SearchFailureState>()));
      await recorder.dispose();
    });
  });
}
