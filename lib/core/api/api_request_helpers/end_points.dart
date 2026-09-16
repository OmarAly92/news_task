import 'package:news_task/core/utils/environment_keys.dart';

sealed class EndPoints {
  static const String baseUrl = EnvironmentKeys.baseUrl;

  /// NEWS
  static const String topics = '/topics';
  static const String sources = '/sources';
  static const String feed = '/feed';
  static const String feedUpdates = '/feed/updates';
  static const String articles = '/articles';
  static String articleById(String articleId) => '/articles/$articleId';
  static String articleReactions(String articleId) =>
      '/articles/$articleId/reactions';
  static const String search = '/search';
  static const String suggest = '/suggest';
  static const String bookmarks = '/bookmarks';
  static String bookmarkById(String articleId) => '/bookmarks/$articleId';
  static const String sync = '/sync';
  static const String flags = '/flags';
  static const String trending = '/trending';
}
