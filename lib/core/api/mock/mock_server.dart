import 'dart:math';

import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/mock/mock_asset_loader.dart';
import 'package:news_task/core/api/mock/mock_http_exception.dart';
import 'package:news_task/core/api/mock/mock_server_config.dart';
import 'package:news_task/core/api/mock/mock_store.dart';

class MockServer {
  MockServer({MockAssetLoader? loader, MockServerConfig? config})
    : _loader = loader ?? MockAssetLoader(),
      config = config ?? MockServerConfig() {
    _store = MockStore(_loader);
  }

  final MockAssetLoader _loader;
  final MockServerConfig config;
  late final MockStore _store;
  final Random _random = Random();

  static final RegExp _articlePattern = RegExp(r'^/articles/([^/]+)$');
  static final RegExp _reactionPattern = RegExp(
    r'^/articles/([^/]+)/reactions$',
  );
  static final RegExp _bookmarkPattern = RegExp(r'^/bookmarks/([^/]+)$');

  Future<dynamic> handle(
    String method,
    String path, {
    Map<String, dynamic>? query,
    dynamic body,
  }) async {
    await Future<void>.delayed(config.latency);
    _maybeFail(path);
    await _store.ensureLoaded();
    final q = query ?? const {};
    final data = body is Map
        ? Map<String, dynamic>.from(body)
        : <String, dynamic>{};

    switch ((method, path)) {
      case ('GET', EndPoints.topics):
        return _loader.load('topics.json');
      case ('GET', EndPoints.sources):
        return _sources(q['topicId'] as String?);
      case ('GET', EndPoints.feed):
        return _feed(q);
      case ('GET', EndPoints.feedUpdates):
        return _store.releasePendingUpdates();
      case ('GET', EndPoints.search):
        return _search(q);
      case ('GET', EndPoints.suggest):
        return _suggest(q['q'] as String? ?? '');
      case ('GET', EndPoints.bookmarks):
        return {
          'data': _store.bookmarkedIds(),
          'version': _store.bookmarksVersion,
        };
      case ('POST', EndPoints.sync):
        return _sync(data);
      case ('GET', EndPoints.flags):
        return _loader.load('flags.json');
      case ('GET', EndPoints.trending):
        return _loader.load('trending.json');
    }

    final reaction = _reactionPattern.firstMatch(path);
    if (method == 'POST' && reaction != null) {
      return _react(reaction.group(1)!, data);
    }
    final article = _articlePattern.firstMatch(path);
    if (method == 'GET' && article != null) {
      return _article(article.group(1)!);
    }
    final bookmark = _bookmarkPattern.firstMatch(path);
    if (method == 'PUT' && bookmark != null) {
      return _bookmark(bookmark.group(1)!, data);
    }
    throw MockHttpException.notFound('$method $path');
  }

  void _maybeFail(String path) {
    final forced =
        config.failNextRequest || config.alwaysFailPaths.contains(path);
    config.failNextRequest = false;
    if (forced || _random.nextDouble() < config.failureRate) {
      throw MockHttpException.temporaryFailure();
    }
  }

  Future<dynamic> _sources(String? topicId) async {
    final all = await _loader.loadMap('sources.json');
    if (topicId == null) return all;
    if (!all.containsKey(topicId)) throw MockHttpException.notFound('Topic');
    return {'topicId': topicId, 'data': all[topicId]};
  }

  Map<String, dynamic> _feed(Map<String, dynamic> q) {
    final pageSize = _int(q['pageSize']) ?? 10;
    final cursor = q['cursor'] as String?;
    final page = cursor != null
        ? int.tryParse(cursor.replaceFirst('feed_', '')) ?? 1
        : _int(q['page']) ?? 1;
    final items = _store.feedArticles(
      topicId: _blankToNull(q['topic']),
      source: _blankToNull(q['source']),
    );
    return _paginate(items, page, pageSize, _store.toFeedItem, cursors: true);
  }

  Map<String, dynamic> _search(Map<String, dynamic> q) {
    final query = (q['q'] as String? ?? '').trim().toLowerCase();
    final topic = _blankToNull(q['topic']);
    final source = _blankToNull(q['source']);
    final from = _blankToNull(q['from']);
    final to = _blankToNull(q['to']);
    final hits = query.isEmpty
        ? <Map<String, dynamic>>[]
        : (_store
              .searchableArticles()
              .where((a) => _matches(a, query))
              .where((a) => topic == null || a['topicId'] == topic)
              .where((a) => source == null || a['source'] == source)
              .where(
                (a) =>
                    from == null ||
                    (a['publishedAt'] as String).compareTo(from) >= 0,
              )
              .where(
                (a) =>
                    to == null ||
                    (a['publishedAt'] as String).compareTo(to) <= 0,
              )
              .toList()
            ..sort(
              (a, b) => (b['publishedAt'] as String).compareTo(
                a['publishedAt'] as String,
              ),
            ));
    return {
      'query': query,
      ..._paginate(
        hits,
        _int(q['page']) ?? 1,
        _int(q['pageSize']) ?? 10,
        _store.toSearchItem,
      ),
    };
  }

  bool _matches(Map<String, dynamic> a, String query) =>
      (a['title'] as String).toLowerCase().contains(query) ||
      (a['summary'] as String).toLowerCase().contains(query) ||
      (a['tags'] as List).any((t) => (t as String).contains(query));

  Future<Map<String, dynamic>> _suggest(String q) async {
    final prefix = q.trim().toLowerCase();
    final file = await _loader.loadMap('search/suggestions.json');
    final index = Map<String, dynamic>.from(file['index'] as Map);
    List<String> suggestions = List<String>.from(index[prefix] ?? []);
    if (suggestions.isEmpty && prefix.isNotEmpty) {
      suggestions = _store
          .searchableArticles()
          .expand((a) => (a['tags'] as List).cast<String>())
          .where((t) => t.startsWith(prefix))
          .toSet()
          .take(6)
          .toList();
    }
    return {'q': prefix, 'suggestions': suggestions};
  }

  Map<String, dynamic> _article(String id) {
    if (_store.isDeleted(id)) {
      return {
        'status': 'unavailable',
        'articleId': id,
        'reason': 'removed_by_publisher',
      };
    }
    final article = _store.article(id);
    if (article == null) throw MockHttpException.notFound('Article');
    return Map<String, dynamic>.from(article);
  }

  Map<String, dynamic> _react(String id, Map<String, dynamic> body) {
    final article = _store.article(id);
    if (article == null || _store.isDeleted(id)) {
      throw MockHttpException.notFound('Article');
    }
    final reaction = body['reaction'] as String?;
    if (reaction != 'like' && reaction != 'unlike') {
      throw MockHttpException.badRequest('reaction must be like or unlike');
    }
    final key = body['clientMutationId'] as String?;
    final expectedVersion = _int(body['expectedVersion']);
    if (!_store.wasProcessed(key)) {
      if (expectedVersion != null && expectedVersion != article['version']) {
        return {
          'status': 'conflict',
          'articleId': id,
          'serverState': {
            'isLiked': article['isLiked'],
            'likes': article['likes'],
            'version': article['version'],
          },
        };
      }
      _store.setLiked(id, reaction == 'like');
      _store.markProcessed(key);
    }
    return {
      'status': 'success',
      'articleId': id,
      'reaction': reaction,
      'likes': article['likes'],
      'version': article['version'],
    };
  }

  Map<String, dynamic> _bookmark(String id, Map<String, dynamic> body) {
    if (!_store.exists(id)) throw MockHttpException.notFound('Article');
    final bookmarked = body['bookmarked'] == true;
    _store.setBookmarked(id, bookmarked);
    return {
      'bookmarked': bookmarked,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };
  }

  Map<String, dynamic> _sync(Map<String, dynamic> body) {
    final mutations = (body['mutations'] as List? ?? []).map(
      (m) => Map<String, dynamic>.from(m as Map),
    );
    final applied = <String>[];
    final conflicts = <Map<String, dynamic>>[];
    for (final mutation in mutations) {
      final key = mutation['idempotencyKey'] as String?;
      final payload = Map<String, dynamic>.from(
        mutation['payload'] as Map? ?? {},
      );
      final articleId = payload['articleId'] as String?;
      final article = articleId == null ? null : _store.article(articleId);
      if (key == null || article == null || _store.isDeleted(articleId!)) {
        conflicts.add({
          'idempotencyKey': key,
          'articleId': articleId,
          'reason': 'unavailable',
        });
        continue;
      }
      if (_store.wasProcessed(key)) {
        applied.add(key);
        continue;
      }
      switch (mutation['op']) {
        case 'set_reaction':
          final wantLiked = payload['reaction'] == 'like';
          if (article['isLiked'] == wantLiked) {
            conflicts.add({
              'idempotencyKey': key,
              'articleId': articleId,
              'serverLikes': article['likes'],
              'isLiked': article['isLiked'],
              'version': article['version'],
            });
          } else {
            _store.setLiked(articleId, wantLiked);
            applied.add(key);
          }
        case 'set_bookmark':
          _store.setBookmarked(articleId, payload['bookmarked'] == true);
          applied.add(key);
        default:
          conflicts.add({'idempotencyKey': key, 'reason': 'unknown_op'});
      }
      _store.markProcessed(key);
    }
    _store.syncVersion++;
    return {
      'status': conflicts.isEmpty ? 'success' : 'review_required',
      'newVersion': _store.syncVersion,
      'applied': applied,
      'conflicts': conflicts,
    };
  }

  Map<String, dynamic> _paginate(
    List<Map<String, dynamic>> items,
    int page,
    int pageSize,
    Map<String, dynamic> Function(Map<String, dynamic>) project, {
    bool cursors = false,
  }) {
    final start = (page - 1) * pageSize;
    final slice = start >= items.length
        ? <Map<String, dynamic>>[]
        : items.sublist(start, min(start + pageSize, items.length));
    final hasMore = start + pageSize < items.length;
    return {
      'data': slice.map(project).toList(),
      'page': page,
      'pageSize': pageSize,
      'total': items.length,
      if (cursors) 'nextCursor': hasMore ? 'feed_${page + 1}' : null,
    };
  }

  int? _int(dynamic value) =>
      value is int ? value : int.tryParse(value?.toString() ?? '');

  String? _blankToNull(dynamic value) {
    final s = value?.toString();
    return s == null || s.isEmpty ? null : s;
  }
}
