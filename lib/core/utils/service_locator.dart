import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/dio_consumer.dart';
import 'package:news_task/core/api/mock/mock_api_consumer.dart';
import 'package:news_task/core/api/mock/mock_server.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/articles/articles_dao.dart';
import 'package:news_task/core/database/tables/bookmarks/bookmarks_dao.dart';
import 'package:news_task/core/database/tables/feed_items/feed_items_dao.dart';
import 'package:news_task/core/database/tables/outbox/outbox_dao.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/utils/environment_keys.dart';
import 'package:news_task/feature/article/data/data_source/article_local_data_source.dart';
import 'package:news_task/feature/article/data/data_source/article_remote_data_source.dart';
import 'package:news_task/feature/article/data/repository/article_repository.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/search/data/data_source/search_remote_data_source.dart';
import 'package:news_task/feature/search/data/repository/search_repository.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_local_data_source.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_remote_data_source.dart';
import 'package:news_task/feature/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:news_task/feature/bookmarks/presentation/bookmarks_screen/logic/bookmarks_cubit.dart';
import 'package:news_task/feature/reactions/data/data_source/reactions_local_data_source.dart';
import 'package:news_task/feature/reactions/data/data_source/reactions_remote_data_source.dart';
import 'package:news_task/feature/reactions/data/repository/reactions_repository.dart';
import 'package:news_task/feature/sync/data/data_source/sync_local_data_source.dart';
import 'package:news_task/feature/sync/data/data_source/sync_remote_data_source.dart';
import 'package:news_task/feature/sync/data/repository/sync_repository.dart';
import 'package:news_task/feature/sync/presentation/logic/sync_cubit.dart';
import 'package:news_task/feature/feed/data/data_source/feed_local_data_source.dart';
import 'package:news_task/feature/feed/data/data_source/feed_remote_data_source.dart';
import 'package:news_task/feature/feed/data/repository/feed_repository.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/app_nav_bar/presentation/app_nav_bar_screen/logic/app_nav_bar_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    /// Core & Packages Setup
    _coreSetup();

    _appNavBarFeatureSetup();
    _feedFeatureSetup();
    _articleFeatureSetup();
    _searchFeatureSetup();
    _bookmarksFeatureSetup();
    _reactionsFeatureSetup();
    _syncFeatureSetup();
  }

  static void _appNavBarFeatureSetup() {
    /// Blocs
    sl.registerFactory<AppNavBarCubit>(() => AppNavBarCubit());
  }

  static void _feedFeatureSetup() {
    /// Blocs
    sl.registerFactory<FeedCubit>(
      () => FeedCubit(
        sl<FeedRepository>(),
        sl<BookmarksRepository>(),
        sl<ReactionsRepository>(),
        sl<NetworkCubit>(),
      ),
    );

    /// Repository
    sl.registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImp(
        sl<FeedRemoteDataSource>(),
        sl<FeedLocalDataSource>(),
        sl<NetworkStatus>(),
      ),
    );

    /// Data Sources
    sl.registerLazySingleton<FeedRemoteDataSource>(
      () => FeedRemoteDataSourceImp(sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<FeedLocalDataSource>(
      () => FeedLocalDataSourceImp(sl<FeedItemsDao>()),
    );
    sl.registerLazySingleton<FeedItemsDao>(
      () => FeedItemsDao(sl<AppDatabase>()),
    );
  }

  static void _articleFeatureSetup() {
    /// Blocs
    sl.registerFactoryParam<ArticleDetailsCubit, String, void>(
      (articleId, _) => ArticleDetailsCubit(
        sl<ArticleRepository>(),
        sl<BookmarksRepository>(),
        sl<ReactionsRepository>(),
        articleId,
      ),
    );

    /// Repository
    sl.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImp(
        sl<ArticleRemoteDataSource>(),
        sl<ArticleLocalDataSource>(),
        sl<NetworkStatus>(),
      ),
    );

    /// Data Sources
    sl.registerLazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImp(sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<ArticleLocalDataSource>(
      () => ArticleLocalDataSourceImp(sl<ArticlesDao>()),
    );
    sl.registerLazySingleton<ArticlesDao>(() => ArticlesDao(sl<AppDatabase>()));
  }

  static void _searchFeatureSetup() {
    /// Blocs
    sl.registerFactory<SearchCubit>(
      () => SearchCubit(sl<SearchRepository>(), sl<FeedRepository>()),
    );

    /// Repository
    sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImp(
        sl<SearchRemoteDataSource>(),
        sl<NetworkStatus>(),
      ),
    );

    /// Data Sources
    sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImp(sl<ApiConsumer>()),
    );
  }

  static void _bookmarksFeatureSetup() {
    /// Blocs
    sl.registerFactory<BookmarksCubit>(
      () => BookmarksCubit(sl<BookmarksRepository>()),
    );

    /// Repository
    sl.registerLazySingleton<BookmarksRepository>(
      () => BookmarksRepositoryImp(
        sl<BookmarksRemoteDataSource>(),
        sl<BookmarksLocalDataSource>(),
        sl<NetworkStatus>(),
      ),
    );

    /// Data Sources
    sl.registerLazySingleton<BookmarksRemoteDataSource>(
      () => BookmarksRemoteDataSourceImp(sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<BookmarksLocalDataSource>(
      () => BookmarksLocalDataSourceImp(sl<BookmarksDao>()),
    );
    sl.registerLazySingleton<BookmarksDao>(
      () => BookmarksDao(sl<AppDatabase>()),
    );
  }

  static void _reactionsFeatureSetup() {
    /// Repository
    sl.registerLazySingleton<ReactionsRepository>(
      () => ReactionsRepositoryImp(
        sl<ReactionsRemoteDataSource>(),
        sl<ReactionsLocalDataSource>(),
        sl<NetworkStatus>(),
      ),
    );

    /// Data Sources
    sl.registerLazySingleton<ReactionsRemoteDataSource>(
      () => ReactionsRemoteDataSourceImp(sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<ReactionsLocalDataSource>(
      () => ReactionsLocalDataSourceImp(
        sl<OutboxDao>(),
        sl<ArticlesDao>(),
        sl<FeedItemsDao>(),
      ),
    );
    sl.registerLazySingleton<OutboxDao>(() => OutboxDao(sl<AppDatabase>()));
  }

  static void _syncFeatureSetup() {
    /// Blocs
    sl.registerLazySingleton<SyncCubit>(
      () => SyncCubit(sl<SyncRepository>(), sl<NetworkCubit>()),
    );

    /// Repository
    sl.registerLazySingleton<SyncRepository>(
      () => SyncRepositoryImp(
        sl<SyncRemoteDataSource>(),
        sl<SyncLocalDataSource>(),
        sl<BookmarksLocalDataSource>(),
        sl<ReactionsRepository>(),
        sl<NetworkStatus>(),
      ),
    );

    /// Data Sources
    sl.registerLazySingleton<SyncRemoteDataSource>(
      () => SyncRemoteDataSourceImp(sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<SyncLocalDataSource>(
      () => SyncLocalDataSourceImp(sl<OutboxDao>()),
    );
  }

  static void _coreSetup() {
    /// Core
    sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
    sl.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImp(sl<InternetConnection>(), sl<Connectivity>()),
    );
    sl.registerLazySingleton<NetworkCubit>(
      () => NetworkCubit(sl<NetworkStatus>()),
    );
    sl.registerLazySingleton<MockServer>(() => MockServer());
    sl.registerLazySingleton<ApiConsumer>(
      () => EnvironmentKeys.useMockApi
          ? MockApiConsumer(sl<MockServer>())
          : DioConsumer(),
    );

    /// External Packages
    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<Connectivity>(Connectivity.new);
    sl.registerLazySingleton<InternetConnection>(
      () => InternetConnection.createInstance(
        checkInterval: const Duration(seconds: 3),
        useDefaultOptions: false,
        triggerStream: sl<Connectivity>().onConnectivityChanged,
        customCheckOptions: [
          InternetCheckOption(
            uri: Uri.parse('https://1.1.1.1'),
            timeout: const Duration(seconds: 2),
          ),
          InternetCheckOption(
            uri: Uri.parse('https://cloudflare.com/cdn-cgi/trace'),
            timeout: const Duration(seconds: 2),
          ),
          InternetCheckOption(
            uri: Uri.parse('https://www.google.com/generate_204'),
            timeout: const Duration(seconds: 2),
          ),
        ],
      ),
    );
  }
}
