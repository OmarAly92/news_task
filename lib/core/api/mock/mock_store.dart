import 'package:news_task/core/api/mock/mock_asset_loader.dart';

class MockStore {
  MockStore(this._loader);

  final MockAssetLoader _loader;

  final Map<String, Map<String, dynamic>> _articles = {};
  final List<String> _feedIds = [];
  final Set<String> _pendingNewIds = {};
  final Set<String> _deletedIds = {};
  final Set<String> _processedMutationKeys = {};
  Map<String, dynamic> _pendingUpdates = {};

  int bookmarksVersion = 12;
  int syncVersion = 18;
  bool _loaded = false;

  static const List<String> _feedItemKeys = [
    'id',
    'title',
    'summary',
    'source',
    'author',
    'topicId',
    'publishedAt',
    'image',
    'tags',
    'likes',
    'comments',
    'isLiked',
    'isBookmarked',
    'version',
  ];

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    final articles = await _loader.loadList('articles.json');
    for (final article in articles) {
      _articles[article['id'] as String] = article;
    }
    final feed = await _loader.loadMap('feed/all.json');
    _feedIds.addAll(
      (feed['data'] as List).map((e) => (e as Map)['id'] as String),
    );
    _pendingUpdates = await _loader.loadMap('feed/updates.json');
    _pendingNewIds.addAll((_pendingUpdates['newItems'] as List).cast<String>());
    final bookmarks = await _loader.loadMap('bookmarks/list.json');
    bookmarksVersion = bookmarks['version'] as int? ?? bookmarksVersion;
    _loaded = true;
  }

  Map<String, dynamic>? article(String id) => _articles[id];

  bool isDeleted(String id) => _deletedIds.contains(id);

  bool exists(String id) => _articles.containsKey(id);

  List<Map<String, dynamic>> feedArticles({String? topicId, String? source}) =>
      _feedIds
          .where((id) => !_deletedIds.contains(id))
          .map((id) => _articles[id]!)
          .where((a) => topicId == null || a['topicId'] == topicId)
          .where((a) => source == null || a['source'] == source)
          .toList();

  List<Map<String, dynamic>> searchableArticles() =>
      _articles.values.where((a) => !_deletedIds.contains(a['id'])).toList();

  List<String> bookmarkedIds() => _articles.values
      .where((a) => a['isBookmarked'] == true && !_deletedIds.contains(a['id']))
      .map((a) => a['id'] as String)
      .toList();

  Map<String, dynamic> toFeedItem(Map<String, dynamic> article) => {
    for (final key in _feedItemKeys)
      if (article.containsKey(key)) key: article[key],
  };

  Map<String, dynamic> toSearchItem(Map<String, dynamic> article) => {
    'id': article['id'],
    'title': article['title'],
    'summary': article['summary'],
    'source': article['source'],
    'topicId': article['topicId'],
    'publishedAt': article['publishedAt'],
    'image': article['image'],
  };

  Map<String, dynamic> releasePendingUpdates() {
    final released = {
      'newItems': _pendingNewIds.toList(),
      'updatedItems': List<String>.from(_pendingUpdates['updatedItems'] ?? []),
      'deletedItems': List<String>.from(_pendingUpdates['deletedItems'] ?? []),
      'serverTime': DateTime.now().toUtc().toIso8601String(),
    };
    for (final id in _pendingNewIds) {
      if (!_feedIds.contains(id)) _feedIds.insert(0, id);
    }
    _pendingNewIds.clear();
    for (final id in released['deletedItems'] as List<String>) {
      _deletedIds.add(id);
    }
    for (final id in released['updatedItems'] as List<String>) {
      final article = _articles[id];
      if (article == null) continue;
      article['likes'] = (article['likes'] as int? ?? 0) + 2;
      article['version'] = (article['version'] as int? ?? 0) + 1;
      article['updatedAt'] = released['serverTime'];
    }
    _pendingUpdates = {'updatedItems': [], 'deletedItems': []};
    _sortFeed();
    return released;
  }

  bool wasProcessed(String? mutationKey) =>
      mutationKey != null && _processedMutationKeys.contains(mutationKey);

  void markProcessed(String? mutationKey) {
    if (mutationKey != null) _processedMutationKeys.add(mutationKey);
  }

  void setLiked(String id, bool liked) {
    final article = _articles[id]!;
    final wasLiked = article['isLiked'] == true;
    if (wasLiked == liked) return;
    article['isLiked'] = liked;
    article['likes'] = (article['likes'] as int? ?? 0) + (liked ? 1 : -1);
    article['version'] = (article['version'] as int? ?? 0) + 1;
  }

  void setBookmarked(String id, bool bookmarked) {
    _articles[id]!['isBookmarked'] = bookmarked;
    bookmarksVersion++;
  }

  void _sortFeed() {
    _feedIds.sort(
      (a, b) => (_articles[b]!['publishedAt'] as String).compareTo(
        _articles[a]!['publishedAt'] as String,
      ),
    );
  }
}
