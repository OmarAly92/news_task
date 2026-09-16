import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/feature/article/data/data_source/article_local_data_source.dart';
import 'package:news_task/feature/article/data/data_source/article_remote_data_source.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_local_data_source.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_remote_data_source.dart';
import 'package:news_task/feature/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:news_task/feature/feed/data/data_source/feed_local_data_source.dart';
import 'package:news_task/feature/feed/data/data_source/feed_remote_data_source.dart';
import 'package:news_task/feature/feed/data/repository/feed_repository.dart';
import 'package:news_task/feature/reactions/data/data_source/reactions_local_data_source.dart';
import 'package:news_task/feature/reactions/data/data_source/reactions_remote_data_source.dart';
import 'package:news_task/feature/reactions/data/repository/reactions_repository.dart';
import 'package:news_task/feature/search/data/repository/search_repository.dart';
import 'package:news_task/feature/sync/data/data_source/sync_local_data_source.dart';
import 'package:news_task/feature/sync/data/data_source/sync_remote_data_source.dart';
import 'package:news_task/feature/sync/data/repository/sync_repository.dart';

class MockApiConsumer extends Mock implements ApiConsumer {}

class MockNetworkStatus extends Mock implements NetworkStatus {}

class MockFeedRemoteDataSource extends Mock implements FeedRemoteDataSource {}

class MockFeedLocalDataSource extends Mock implements FeedLocalDataSource {}

class MockFeedRepository extends Mock implements FeedRepository {}

class MockArticleRemoteDataSource extends Mock
    implements ArticleRemoteDataSource {}

class MockArticleLocalDataSource extends Mock
    implements ArticleLocalDataSource {}

class MockBookmarksRemoteDataSource extends Mock
    implements BookmarksRemoteDataSource {}

class MockBookmarksLocalDataSource extends Mock
    implements BookmarksLocalDataSource {}

class MockBookmarksRepository extends Mock implements BookmarksRepository {}

class MockReactionsRemoteDataSource extends Mock
    implements ReactionsRemoteDataSource {}

class MockReactionsLocalDataSource extends Mock
    implements ReactionsLocalDataSource {}

class MockReactionsRepository extends Mock implements ReactionsRepository {}

class MockSearchRepository extends Mock implements SearchRepository {}

class MockSyncRemoteDataSource extends Mock implements SyncRemoteDataSource {}

class MockSyncLocalDataSource extends Mock implements SyncLocalDataSource {}

class MockSyncRepository extends Mock implements SyncRepository {}
