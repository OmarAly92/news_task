// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, BookmarkEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorAvatarMeta = const VerificationMeta(
    'authorAvatar',
  );
  @override
  late final GeneratedColumn<String> authorAvatar = GeneratedColumn<String>(
    'author_avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _pendingRemovalMeta = const VerificationMeta(
    'pendingRemoval',
  );
  @override
  late final GeneratedColumn<bool> pendingRemoval = GeneratedColumn<bool>(
    'pending_removal',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_removal" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    articleId,
    title,
    summary,
    source,
    topicId,
    authorName,
    authorAvatar,
    image,
    publishedAt,
    savedAt,
    isSynced,
    pendingRemoval,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarkEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    }
    if (data.containsKey('author_avatar')) {
      context.handle(
        _authorAvatarMeta,
        authorAvatar.isAcceptableOrUnknown(
          data['author_avatar']!,
          _authorAvatarMeta,
        ),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('pending_removal')) {
      context.handle(
        _pendingRemovalMeta,
        pendingRemoval.isAcceptableOrUnknown(
          data['pending_removal']!,
          _pendingRemovalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId};
  @override
  BookmarkEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarkEntity(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      ),
      authorAvatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_avatar'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      pendingRemoval: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_removal'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class BookmarkEntity extends DataClass implements Insertable<BookmarkEntity> {
  final String articleId;
  final String? title;
  final String? summary;
  final String? source;
  final String? topicId;
  final String? authorName;
  final String? authorAvatar;
  final String? image;
  final DateTime? publishedAt;
  final DateTime savedAt;
  final bool isSynced;
  final bool pendingRemoval;
  const BookmarkEntity({
    required this.articleId,
    this.title,
    this.summary,
    this.source,
    this.topicId,
    this.authorName,
    this.authorAvatar,
    this.image,
    this.publishedAt,
    required this.savedAt,
    required this.isSynced,
    required this.pendingRemoval,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<String>(articleId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    if (!nullToAbsent || authorName != null) {
      map['author_name'] = Variable<String>(authorName);
    }
    if (!nullToAbsent || authorAvatar != null) {
      map['author_avatar'] = Variable<String>(authorAvatar);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    map['saved_at'] = Variable<DateTime>(savedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    map['pending_removal'] = Variable<bool>(pendingRemoval);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      articleId: Value(articleId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      authorName: authorName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorName),
      authorAvatar: authorAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(authorAvatar),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      savedAt: Value(savedAt),
      isSynced: Value(isSynced),
      pendingRemoval: Value(pendingRemoval),
    );
  }

  factory BookmarkEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarkEntity(
      articleId: serializer.fromJson<String>(json['articleId']),
      title: serializer.fromJson<String?>(json['title']),
      summary: serializer.fromJson<String?>(json['summary']),
      source: serializer.fromJson<String?>(json['source']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      authorName: serializer.fromJson<String?>(json['authorName']),
      authorAvatar: serializer.fromJson<String?>(json['authorAvatar']),
      image: serializer.fromJson<String?>(json['image']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      pendingRemoval: serializer.fromJson<bool>(json['pendingRemoval']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<String>(articleId),
      'title': serializer.toJson<String?>(title),
      'summary': serializer.toJson<String?>(summary),
      'source': serializer.toJson<String?>(source),
      'topicId': serializer.toJson<String?>(topicId),
      'authorName': serializer.toJson<String?>(authorName),
      'authorAvatar': serializer.toJson<String?>(authorAvatar),
      'image': serializer.toJson<String?>(image),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'savedAt': serializer.toJson<DateTime>(savedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'pendingRemoval': serializer.toJson<bool>(pendingRemoval),
    };
  }

  BookmarkEntity copyWith({
    String? articleId,
    Value<String?> title = const Value.absent(),
    Value<String?> summary = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> topicId = const Value.absent(),
    Value<String?> authorName = const Value.absent(),
    Value<String?> authorAvatar = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<DateTime?> publishedAt = const Value.absent(),
    DateTime? savedAt,
    bool? isSynced,
    bool? pendingRemoval,
  }) => BookmarkEntity(
    articleId: articleId ?? this.articleId,
    title: title.present ? title.value : this.title,
    summary: summary.present ? summary.value : this.summary,
    source: source.present ? source.value : this.source,
    topicId: topicId.present ? topicId.value : this.topicId,
    authorName: authorName.present ? authorName.value : this.authorName,
    authorAvatar: authorAvatar.present ? authorAvatar.value : this.authorAvatar,
    image: image.present ? image.value : this.image,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    savedAt: savedAt ?? this.savedAt,
    isSynced: isSynced ?? this.isSynced,
    pendingRemoval: pendingRemoval ?? this.pendingRemoval,
  );
  BookmarkEntity copyWithCompanion(BookmarksCompanion data) {
    return BookmarkEntity(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      source: data.source.present ? data.source.value : this.source,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      authorAvatar: data.authorAvatar.present
          ? data.authorAvatar.value
          : this.authorAvatar,
      image: data.image.present ? data.image.value : this.image,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      pendingRemoval: data.pendingRemoval.present
          ? data.pendingRemoval.value
          : this.pendingRemoval,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkEntity(')
          ..write('articleId: $articleId, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('source: $source, ')
          ..write('topicId: $topicId, ')
          ..write('authorName: $authorName, ')
          ..write('authorAvatar: $authorAvatar, ')
          ..write('image: $image, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('savedAt: $savedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('pendingRemoval: $pendingRemoval')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    articleId,
    title,
    summary,
    source,
    topicId,
    authorName,
    authorAvatar,
    image,
    publishedAt,
    savedAt,
    isSynced,
    pendingRemoval,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarkEntity &&
          other.articleId == this.articleId &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.source == this.source &&
          other.topicId == this.topicId &&
          other.authorName == this.authorName &&
          other.authorAvatar == this.authorAvatar &&
          other.image == this.image &&
          other.publishedAt == this.publishedAt &&
          other.savedAt == this.savedAt &&
          other.isSynced == this.isSynced &&
          other.pendingRemoval == this.pendingRemoval);
}

class BookmarksCompanion extends UpdateCompanion<BookmarkEntity> {
  final Value<String> articleId;
  final Value<String?> title;
  final Value<String?> summary;
  final Value<String?> source;
  final Value<String?> topicId;
  final Value<String?> authorName;
  final Value<String?> authorAvatar;
  final Value<String?> image;
  final Value<DateTime?> publishedAt;
  final Value<DateTime> savedAt;
  final Value<bool> isSynced;
  final Value<bool> pendingRemoval;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.articleId = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.source = const Value.absent(),
    this.topicId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorAvatar = const Value.absent(),
    this.image = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.pendingRemoval = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String articleId,
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.source = const Value.absent(),
    this.topicId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorAvatar = const Value.absent(),
    this.image = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.pendingRemoval = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId);
  static Insertable<BookmarkEntity> custom({
    Expression<String>? articleId,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? source,
    Expression<String>? topicId,
    Expression<String>? authorName,
    Expression<String>? authorAvatar,
    Expression<String>? image,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? savedAt,
    Expression<bool>? isSynced,
    Expression<bool>? pendingRemoval,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (source != null) 'source': source,
      if (topicId != null) 'topic_id': topicId,
      if (authorName != null) 'author_name': authorName,
      if (authorAvatar != null) 'author_avatar': authorAvatar,
      if (image != null) 'image': image,
      if (publishedAt != null) 'published_at': publishedAt,
      if (savedAt != null) 'saved_at': savedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (pendingRemoval != null) 'pending_removal': pendingRemoval,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith({
    Value<String>? articleId,
    Value<String?>? title,
    Value<String?>? summary,
    Value<String?>? source,
    Value<String?>? topicId,
    Value<String?>? authorName,
    Value<String?>? authorAvatar,
    Value<String?>? image,
    Value<DateTime?>? publishedAt,
    Value<DateTime>? savedAt,
    Value<bool>? isSynced,
    Value<bool>? pendingRemoval,
    Value<int>? rowid,
  }) {
    return BookmarksCompanion(
      articleId: articleId ?? this.articleId,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      source: source ?? this.source,
      topicId: topicId ?? this.topicId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      image: image ?? this.image,
      publishedAt: publishedAt ?? this.publishedAt,
      savedAt: savedAt ?? this.savedAt,
      isSynced: isSynced ?? this.isSynced,
      pendingRemoval: pendingRemoval ?? this.pendingRemoval,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (authorAvatar.present) {
      map['author_avatar'] = Variable<String>(authorAvatar.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (pendingRemoval.present) {
      map['pending_removal'] = Variable<bool>(pendingRemoval.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('articleId: $articleId, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('source: $source, ')
          ..write('topicId: $topicId, ')
          ..write('authorName: $authorName, ')
          ..write('authorAvatar: $authorAvatar, ')
          ..write('image: $image, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('savedAt: $savedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('pendingRemoval: $pendingRemoval, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxMutationsTable extends OutboxMutations
    with TableInfo<$OutboxMutationsTable, OutboxEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxMutationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _opMeta = const VerificationMeta('op');
  @override
  late final GeneratedColumn<String> op = GeneratedColumn<String>(
    'op',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idempotencyKey,
    op,
    articleId,
    payload,
    createdAt,
    attempts,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_mutations';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('op')) {
      context.handle(_opMeta, op.isAcceptableOrUnknown(data['op']!, _opMeta));
    } else if (isInserting) {
      context.missing(_opMeta);
    }
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      op: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op'],
      )!,
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
    );
  }

  @override
  $OutboxMutationsTable createAlias(String alias) {
    return $OutboxMutationsTable(attachedDatabase, alias);
  }
}

class OutboxEntity extends DataClass implements Insertable<OutboxEntity> {
  final int id;
  final String idempotencyKey;
  final String op;
  final String articleId;
  final String payload;
  final DateTime createdAt;
  final int attempts;
  const OutboxEntity({
    required this.id,
    required this.idempotencyKey,
    required this.op,
    required this.articleId,
    required this.payload,
    required this.createdAt,
    required this.attempts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['op'] = Variable<String>(op);
    map['article_id'] = Variable<String>(articleId);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempts'] = Variable<int>(attempts);
    return map;
  }

  OutboxMutationsCompanion toCompanion(bool nullToAbsent) {
    return OutboxMutationsCompanion(
      id: Value(id),
      idempotencyKey: Value(idempotencyKey),
      op: Value(op),
      articleId: Value(articleId),
      payload: Value(payload),
      createdAt: Value(createdAt),
      attempts: Value(attempts),
    );
  }

  factory OutboxEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxEntity(
      id: serializer.fromJson<int>(json['id']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      op: serializer.fromJson<String>(json['op']),
      articleId: serializer.fromJson<String>(json['articleId']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attempts: serializer.fromJson<int>(json['attempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'op': serializer.toJson<String>(op),
      'articleId': serializer.toJson<String>(articleId),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attempts': serializer.toJson<int>(attempts),
    };
  }

  OutboxEntity copyWith({
    int? id,
    String? idempotencyKey,
    String? op,
    String? articleId,
    String? payload,
    DateTime? createdAt,
    int? attempts,
  }) => OutboxEntity(
    id: id ?? this.id,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    op: op ?? this.op,
    articleId: articleId ?? this.articleId,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    attempts: attempts ?? this.attempts,
  );
  OutboxEntity copyWithCompanion(OutboxMutationsCompanion data) {
    return OutboxEntity(
      id: data.id.present ? data.id.value : this.id,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      op: data.op.present ? data.op.value : this.op,
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntity(')
          ..write('id: $id, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('op: $op, ')
          ..write('articleId: $articleId, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idempotencyKey,
    op,
    articleId,
    payload,
    createdAt,
    attempts,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxEntity &&
          other.id == this.id &&
          other.idempotencyKey == this.idempotencyKey &&
          other.op == this.op &&
          other.articleId == this.articleId &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.attempts == this.attempts);
}

class OutboxMutationsCompanion extends UpdateCompanion<OutboxEntity> {
  final Value<int> id;
  final Value<String> idempotencyKey;
  final Value<String> op;
  final Value<String> articleId;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<int> attempts;
  const OutboxMutationsCompanion({
    this.id = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.op = const Value.absent(),
    this.articleId = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
  });
  OutboxMutationsCompanion.insert({
    this.id = const Value.absent(),
    required String idempotencyKey,
    required String op,
    required String articleId,
    required String payload,
    this.createdAt = const Value.absent(),
    this.attempts = const Value.absent(),
  }) : idempotencyKey = Value(idempotencyKey),
       op = Value(op),
       articleId = Value(articleId),
       payload = Value(payload);
  static Insertable<OutboxEntity> custom({
    Expression<int>? id,
    Expression<String>? idempotencyKey,
    Expression<String>? op,
    Expression<String>? articleId,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<int>? attempts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (op != null) 'op': op,
      if (articleId != null) 'article_id': articleId,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (attempts != null) 'attempts': attempts,
    });
  }

  OutboxMutationsCompanion copyWith({
    Value<int>? id,
    Value<String>? idempotencyKey,
    Value<String>? op,
    Value<String>? articleId,
    Value<String>? payload,
    Value<DateTime>? createdAt,
    Value<int>? attempts,
  }) {
    return OutboxMutationsCompanion(
      id: id ?? this.id,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      op: op ?? this.op,
      articleId: articleId ?? this.articleId,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      attempts: attempts ?? this.attempts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (op.present) {
      map['op'] = Variable<String>(op.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxMutationsCompanion(')
          ..write('id: $id, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('op: $op, ')
          ..write('articleId: $articleId, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('attempts: $attempts')
          ..write(')'))
        .toString();
  }
}

class $FeedItemsTable extends FeedItems
    with TableInfo<$FeedItemsTable, FeedItemEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedTopicIdMeta = const VerificationMeta(
    'feedTopicId',
  );
  @override
  late final GeneratedColumn<String> feedTopicId = GeneratedColumn<String>(
    'feed_topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _feedPositionMeta = const VerificationMeta(
    'feedPosition',
  );
  @override
  late final GeneratedColumn<int> feedPosition = GeneratedColumn<int>(
    'feed_position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorAvatarMeta = const VerificationMeta(
    'authorAvatar',
  );
  @override
  late final GeneratedColumn<String> authorAvatar = GeneratedColumn<String>(
    'author_avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<int> likes = GeneratedColumn<int>(
    'likes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentsMeta = const VerificationMeta(
    'comments',
  );
  @override
  late final GeneratedColumn<int> comments = GeneratedColumn<int>(
    'comments',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLikedMeta = const VerificationMeta(
    'isLiked',
  );
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
    'is_liked',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_liked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    articleId,
    feedTopicId,
    feedPosition,
    title,
    summary,
    source,
    topicId,
    authorId,
    authorName,
    authorAvatar,
    image,
    tags,
    publishedAt,
    likes,
    comments,
    isLiked,
    version,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedItemEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('feed_topic_id')) {
      context.handle(
        _feedTopicIdMeta,
        feedTopicId.isAcceptableOrUnknown(
          data['feed_topic_id']!,
          _feedTopicIdMeta,
        ),
      );
    }
    if (data.containsKey('feed_position')) {
      context.handle(
        _feedPositionMeta,
        feedPosition.isAcceptableOrUnknown(
          data['feed_position']!,
          _feedPositionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_feedPositionMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    }
    if (data.containsKey('author_avatar')) {
      context.handle(
        _authorAvatarMeta,
        authorAvatar.isAcceptableOrUnknown(
          data['author_avatar']!,
          _authorAvatarMeta,
        ),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('likes')) {
      context.handle(
        _likesMeta,
        likes.isAcceptableOrUnknown(data['likes']!, _likesMeta),
      );
    }
    if (data.containsKey('comments')) {
      context.handle(
        _commentsMeta,
        comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta),
      );
    }
    if (data.containsKey('is_liked')) {
      context.handle(
        _isLikedMeta,
        isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId, feedTopicId};
  @override
  FeedItemEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedItemEntity(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      feedTopicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feed_topic_id'],
      )!,
      feedPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}feed_position'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      ),
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      ),
      authorAvatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_avatar'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      likes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}likes'],
      ),
      comments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comments'],
      ),
      isLiked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_liked'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $FeedItemsTable createAlias(String alias) {
    return $FeedItemsTable(attachedDatabase, alias);
  }
}

class FeedItemEntity extends DataClass implements Insertable<FeedItemEntity> {
  final String articleId;
  final String feedTopicId;
  final int feedPosition;
  final String? title;
  final String? summary;
  final String? source;
  final String? topicId;
  final String? authorId;
  final String? authorName;
  final String? authorAvatar;
  final String? image;
  final String? tags;
  final DateTime? publishedAt;
  final int? likes;
  final int? comments;
  final bool? isLiked;
  final int? version;
  final DateTime cachedAt;
  const FeedItemEntity({
    required this.articleId,
    required this.feedTopicId,
    required this.feedPosition,
    this.title,
    this.summary,
    this.source,
    this.topicId,
    this.authorId,
    this.authorName,
    this.authorAvatar,
    this.image,
    this.tags,
    this.publishedAt,
    this.likes,
    this.comments,
    this.isLiked,
    this.version,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<String>(articleId);
    map['feed_topic_id'] = Variable<String>(feedTopicId);
    map['feed_position'] = Variable<int>(feedPosition);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    if (!nullToAbsent || authorName != null) {
      map['author_name'] = Variable<String>(authorName);
    }
    if (!nullToAbsent || authorAvatar != null) {
      map['author_avatar'] = Variable<String>(authorAvatar);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<int>(likes);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<int>(comments);
    }
    if (!nullToAbsent || isLiked != null) {
      map['is_liked'] = Variable<bool>(isLiked);
    }
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<int>(version);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  FeedItemsCompanion toCompanion(bool nullToAbsent) {
    return FeedItemsCompanion(
      articleId: Value(articleId),
      feedTopicId: Value(feedTopicId),
      feedPosition: Value(feedPosition),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      authorName: authorName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorName),
      authorAvatar: authorAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(authorAvatar),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      likes: likes == null && nullToAbsent
          ? const Value.absent()
          : Value(likes),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      isLiked: isLiked == null && nullToAbsent
          ? const Value.absent()
          : Value(isLiked),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
      cachedAt: Value(cachedAt),
    );
  }

  factory FeedItemEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedItemEntity(
      articleId: serializer.fromJson<String>(json['articleId']),
      feedTopicId: serializer.fromJson<String>(json['feedTopicId']),
      feedPosition: serializer.fromJson<int>(json['feedPosition']),
      title: serializer.fromJson<String?>(json['title']),
      summary: serializer.fromJson<String?>(json['summary']),
      source: serializer.fromJson<String?>(json['source']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      authorName: serializer.fromJson<String?>(json['authorName']),
      authorAvatar: serializer.fromJson<String?>(json['authorAvatar']),
      image: serializer.fromJson<String?>(json['image']),
      tags: serializer.fromJson<String?>(json['tags']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      likes: serializer.fromJson<int?>(json['likes']),
      comments: serializer.fromJson<int?>(json['comments']),
      isLiked: serializer.fromJson<bool?>(json['isLiked']),
      version: serializer.fromJson<int?>(json['version']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<String>(articleId),
      'feedTopicId': serializer.toJson<String>(feedTopicId),
      'feedPosition': serializer.toJson<int>(feedPosition),
      'title': serializer.toJson<String?>(title),
      'summary': serializer.toJson<String?>(summary),
      'source': serializer.toJson<String?>(source),
      'topicId': serializer.toJson<String?>(topicId),
      'authorId': serializer.toJson<String?>(authorId),
      'authorName': serializer.toJson<String?>(authorName),
      'authorAvatar': serializer.toJson<String?>(authorAvatar),
      'image': serializer.toJson<String?>(image),
      'tags': serializer.toJson<String?>(tags),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'likes': serializer.toJson<int?>(likes),
      'comments': serializer.toJson<int?>(comments),
      'isLiked': serializer.toJson<bool?>(isLiked),
      'version': serializer.toJson<int?>(version),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  FeedItemEntity copyWith({
    String? articleId,
    String? feedTopicId,
    int? feedPosition,
    Value<String?> title = const Value.absent(),
    Value<String?> summary = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> topicId = const Value.absent(),
    Value<String?> authorId = const Value.absent(),
    Value<String?> authorName = const Value.absent(),
    Value<String?> authorAvatar = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<DateTime?> publishedAt = const Value.absent(),
    Value<int?> likes = const Value.absent(),
    Value<int?> comments = const Value.absent(),
    Value<bool?> isLiked = const Value.absent(),
    Value<int?> version = const Value.absent(),
    DateTime? cachedAt,
  }) => FeedItemEntity(
    articleId: articleId ?? this.articleId,
    feedTopicId: feedTopicId ?? this.feedTopicId,
    feedPosition: feedPosition ?? this.feedPosition,
    title: title.present ? title.value : this.title,
    summary: summary.present ? summary.value : this.summary,
    source: source.present ? source.value : this.source,
    topicId: topicId.present ? topicId.value : this.topicId,
    authorId: authorId.present ? authorId.value : this.authorId,
    authorName: authorName.present ? authorName.value : this.authorName,
    authorAvatar: authorAvatar.present ? authorAvatar.value : this.authorAvatar,
    image: image.present ? image.value : this.image,
    tags: tags.present ? tags.value : this.tags,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    likes: likes.present ? likes.value : this.likes,
    comments: comments.present ? comments.value : this.comments,
    isLiked: isLiked.present ? isLiked.value : this.isLiked,
    version: version.present ? version.value : this.version,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  FeedItemEntity copyWithCompanion(FeedItemsCompanion data) {
    return FeedItemEntity(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      feedTopicId: data.feedTopicId.present
          ? data.feedTopicId.value
          : this.feedTopicId,
      feedPosition: data.feedPosition.present
          ? data.feedPosition.value
          : this.feedPosition,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      source: data.source.present ? data.source.value : this.source,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      authorAvatar: data.authorAvatar.present
          ? data.authorAvatar.value
          : this.authorAvatar,
      image: data.image.present ? data.image.value : this.image,
      tags: data.tags.present ? data.tags.value : this.tags,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      likes: data.likes.present ? data.likes.value : this.likes,
      comments: data.comments.present ? data.comments.value : this.comments,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
      version: data.version.present ? data.version.value : this.version,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedItemEntity(')
          ..write('articleId: $articleId, ')
          ..write('feedTopicId: $feedTopicId, ')
          ..write('feedPosition: $feedPosition, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('source: $source, ')
          ..write('topicId: $topicId, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName, ')
          ..write('authorAvatar: $authorAvatar, ')
          ..write('image: $image, ')
          ..write('tags: $tags, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('likes: $likes, ')
          ..write('comments: $comments, ')
          ..write('isLiked: $isLiked, ')
          ..write('version: $version, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    articleId,
    feedTopicId,
    feedPosition,
    title,
    summary,
    source,
    topicId,
    authorId,
    authorName,
    authorAvatar,
    image,
    tags,
    publishedAt,
    likes,
    comments,
    isLiked,
    version,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedItemEntity &&
          other.articleId == this.articleId &&
          other.feedTopicId == this.feedTopicId &&
          other.feedPosition == this.feedPosition &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.source == this.source &&
          other.topicId == this.topicId &&
          other.authorId == this.authorId &&
          other.authorName == this.authorName &&
          other.authorAvatar == this.authorAvatar &&
          other.image == this.image &&
          other.tags == this.tags &&
          other.publishedAt == this.publishedAt &&
          other.likes == this.likes &&
          other.comments == this.comments &&
          other.isLiked == this.isLiked &&
          other.version == this.version &&
          other.cachedAt == this.cachedAt);
}

class FeedItemsCompanion extends UpdateCompanion<FeedItemEntity> {
  final Value<String> articleId;
  final Value<String> feedTopicId;
  final Value<int> feedPosition;
  final Value<String?> title;
  final Value<String?> summary;
  final Value<String?> source;
  final Value<String?> topicId;
  final Value<String?> authorId;
  final Value<String?> authorName;
  final Value<String?> authorAvatar;
  final Value<String?> image;
  final Value<String?> tags;
  final Value<DateTime?> publishedAt;
  final Value<int?> likes;
  final Value<int?> comments;
  final Value<bool?> isLiked;
  final Value<int?> version;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const FeedItemsCompanion({
    this.articleId = const Value.absent(),
    this.feedTopicId = const Value.absent(),
    this.feedPosition = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.source = const Value.absent(),
    this.topicId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorAvatar = const Value.absent(),
    this.image = const Value.absent(),
    this.tags = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.likes = const Value.absent(),
    this.comments = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.version = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedItemsCompanion.insert({
    required String articleId,
    this.feedTopicId = const Value.absent(),
    required int feedPosition,
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.source = const Value.absent(),
    this.topicId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorAvatar = const Value.absent(),
    this.image = const Value.absent(),
    this.tags = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.likes = const Value.absent(),
    this.comments = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.version = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId),
       feedPosition = Value(feedPosition);
  static Insertable<FeedItemEntity> custom({
    Expression<String>? articleId,
    Expression<String>? feedTopicId,
    Expression<int>? feedPosition,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? source,
    Expression<String>? topicId,
    Expression<String>? authorId,
    Expression<String>? authorName,
    Expression<String>? authorAvatar,
    Expression<String>? image,
    Expression<String>? tags,
    Expression<DateTime>? publishedAt,
    Expression<int>? likes,
    Expression<int>? comments,
    Expression<bool>? isLiked,
    Expression<int>? version,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (feedTopicId != null) 'feed_topic_id': feedTopicId,
      if (feedPosition != null) 'feed_position': feedPosition,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (source != null) 'source': source,
      if (topicId != null) 'topic_id': topicId,
      if (authorId != null) 'author_id': authorId,
      if (authorName != null) 'author_name': authorName,
      if (authorAvatar != null) 'author_avatar': authorAvatar,
      if (image != null) 'image': image,
      if (tags != null) 'tags': tags,
      if (publishedAt != null) 'published_at': publishedAt,
      if (likes != null) 'likes': likes,
      if (comments != null) 'comments': comments,
      if (isLiked != null) 'is_liked': isLiked,
      if (version != null) 'version': version,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedItemsCompanion copyWith({
    Value<String>? articleId,
    Value<String>? feedTopicId,
    Value<int>? feedPosition,
    Value<String?>? title,
    Value<String?>? summary,
    Value<String?>? source,
    Value<String?>? topicId,
    Value<String?>? authorId,
    Value<String?>? authorName,
    Value<String?>? authorAvatar,
    Value<String?>? image,
    Value<String?>? tags,
    Value<DateTime?>? publishedAt,
    Value<int?>? likes,
    Value<int?>? comments,
    Value<bool?>? isLiked,
    Value<int?>? version,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return FeedItemsCompanion(
      articleId: articleId ?? this.articleId,
      feedTopicId: feedTopicId ?? this.feedTopicId,
      feedPosition: feedPosition ?? this.feedPosition,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      source: source ?? this.source,
      topicId: topicId ?? this.topicId,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      image: image ?? this.image,
      tags: tags ?? this.tags,
      publishedAt: publishedAt ?? this.publishedAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      version: version ?? this.version,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (feedTopicId.present) {
      map['feed_topic_id'] = Variable<String>(feedTopicId.value);
    }
    if (feedPosition.present) {
      map['feed_position'] = Variable<int>(feedPosition.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (authorAvatar.present) {
      map['author_avatar'] = Variable<String>(authorAvatar.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (likes.present) {
      map['likes'] = Variable<int>(likes.value);
    }
    if (comments.present) {
      map['comments'] = Variable<int>(comments.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedItemsCompanion(')
          ..write('articleId: $articleId, ')
          ..write('feedTopicId: $feedTopicId, ')
          ..write('feedPosition: $feedPosition, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('source: $source, ')
          ..write('topicId: $topicId, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName, ')
          ..write('authorAvatar: $authorAvatar, ')
          ..write('image: $image, ')
          ..write('tags: $tags, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('likes: $likes, ')
          ..write('comments: $comments, ')
          ..write('isLiked: $isLiked, ')
          ..write('version: $version, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles
    with TableInfo<$ArticlesTable, ArticleEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorAvatarMeta = const VerificationMeta(
    'authorAvatar',
  );
  @override
  late final GeneratedColumn<String> authorAvatar = GeneratedColumn<String>(
    'author_avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorBioMeta = const VerificationMeta(
    'authorBio',
  );
  @override
  late final GeneratedColumn<String> authorBio = GeneratedColumn<String>(
    'author_bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readTimeMinutesMeta = const VerificationMeta(
    'readTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> readTimeMinutes = GeneratedColumn<int>(
    'read_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _galleryMeta = const VerificationMeta(
    'gallery',
  );
  @override
  late final GeneratedColumn<String> gallery = GeneratedColumn<String>(
    'gallery',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedMeta = const VerificationMeta(
    'related',
  );
  @override
  late final GeneratedColumn<String> related = GeneratedColumn<String>(
    'related',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<int> likes = GeneratedColumn<int>(
    'likes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentsMeta = const VerificationMeta(
    'comments',
  );
  @override
  late final GeneratedColumn<int> comments = GeneratedColumn<int>(
    'comments',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLikedMeta = const VerificationMeta(
    'isLiked',
  );
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
    'is_liked',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_liked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    articleId,
    title,
    summary,
    body,
    source,
    authorId,
    authorName,
    authorAvatar,
    authorBio,
    topicId,
    publishedAt,
    updatedAt,
    readTimeMinutes,
    image,
    gallery,
    tags,
    related,
    likes,
    comments,
    isLiked,
    version,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArticleEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    }
    if (data.containsKey('author_avatar')) {
      context.handle(
        _authorAvatarMeta,
        authorAvatar.isAcceptableOrUnknown(
          data['author_avatar']!,
          _authorAvatarMeta,
        ),
      );
    }
    if (data.containsKey('author_bio')) {
      context.handle(
        _authorBioMeta,
        authorBio.isAcceptableOrUnknown(data['author_bio']!, _authorBioMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('read_time_minutes')) {
      context.handle(
        _readTimeMinutesMeta,
        readTimeMinutes.isAcceptableOrUnknown(
          data['read_time_minutes']!,
          _readTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('gallery')) {
      context.handle(
        _galleryMeta,
        gallery.isAcceptableOrUnknown(data['gallery']!, _galleryMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('related')) {
      context.handle(
        _relatedMeta,
        related.isAcceptableOrUnknown(data['related']!, _relatedMeta),
      );
    }
    if (data.containsKey('likes')) {
      context.handle(
        _likesMeta,
        likes.isAcceptableOrUnknown(data['likes']!, _likesMeta),
      );
    }
    if (data.containsKey('comments')) {
      context.handle(
        _commentsMeta,
        comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta),
      );
    }
    if (data.containsKey('is_liked')) {
      context.handle(
        _isLikedMeta,
        isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId};
  @override
  ArticleEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticleEntity(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      ),
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      ),
      authorAvatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_avatar'],
      ),
      authorBio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_bio'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      ),
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      readTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}read_time_minutes'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      gallery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gallery'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      related: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related'],
      ),
      likes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}likes'],
      ),
      comments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comments'],
      ),
      isLiked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_liked'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class ArticleEntity extends DataClass implements Insertable<ArticleEntity> {
  final String articleId;
  final String? title;
  final String? summary;
  final String? body;
  final String? source;
  final String? authorId;
  final String? authorName;
  final String? authorAvatar;
  final String? authorBio;
  final String? topicId;
  final DateTime? publishedAt;
  final DateTime? updatedAt;
  final int? readTimeMinutes;
  final String? image;
  final String? gallery;
  final String? tags;
  final String? related;
  final int? likes;
  final int? comments;
  final bool? isLiked;
  final int? version;
  final DateTime cachedAt;
  const ArticleEntity({
    required this.articleId,
    this.title,
    this.summary,
    this.body,
    this.source,
    this.authorId,
    this.authorName,
    this.authorAvatar,
    this.authorBio,
    this.topicId,
    this.publishedAt,
    this.updatedAt,
    this.readTimeMinutes,
    this.image,
    this.gallery,
    this.tags,
    this.related,
    this.likes,
    this.comments,
    this.isLiked,
    this.version,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<String>(articleId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    if (!nullToAbsent || authorName != null) {
      map['author_name'] = Variable<String>(authorName);
    }
    if (!nullToAbsent || authorAvatar != null) {
      map['author_avatar'] = Variable<String>(authorAvatar);
    }
    if (!nullToAbsent || authorBio != null) {
      map['author_bio'] = Variable<String>(authorBio);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || readTimeMinutes != null) {
      map['read_time_minutes'] = Variable<int>(readTimeMinutes);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || gallery != null) {
      map['gallery'] = Variable<String>(gallery);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || related != null) {
      map['related'] = Variable<String>(related);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<int>(likes);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<int>(comments);
    }
    if (!nullToAbsent || isLiked != null) {
      map['is_liked'] = Variable<bool>(isLiked);
    }
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<int>(version);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      articleId: Value(articleId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      authorName: authorName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorName),
      authorAvatar: authorAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(authorAvatar),
      authorBio: authorBio == null && nullToAbsent
          ? const Value.absent()
          : Value(authorBio),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      readTimeMinutes: readTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(readTimeMinutes),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      gallery: gallery == null && nullToAbsent
          ? const Value.absent()
          : Value(gallery),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      related: related == null && nullToAbsent
          ? const Value.absent()
          : Value(related),
      likes: likes == null && nullToAbsent
          ? const Value.absent()
          : Value(likes),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      isLiked: isLiked == null && nullToAbsent
          ? const Value.absent()
          : Value(isLiked),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
      cachedAt: Value(cachedAt),
    );
  }

  factory ArticleEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticleEntity(
      articleId: serializer.fromJson<String>(json['articleId']),
      title: serializer.fromJson<String?>(json['title']),
      summary: serializer.fromJson<String?>(json['summary']),
      body: serializer.fromJson<String?>(json['body']),
      source: serializer.fromJson<String?>(json['source']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      authorName: serializer.fromJson<String?>(json['authorName']),
      authorAvatar: serializer.fromJson<String?>(json['authorAvatar']),
      authorBio: serializer.fromJson<String?>(json['authorBio']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      readTimeMinutes: serializer.fromJson<int?>(json['readTimeMinutes']),
      image: serializer.fromJson<String?>(json['image']),
      gallery: serializer.fromJson<String?>(json['gallery']),
      tags: serializer.fromJson<String?>(json['tags']),
      related: serializer.fromJson<String?>(json['related']),
      likes: serializer.fromJson<int?>(json['likes']),
      comments: serializer.fromJson<int?>(json['comments']),
      isLiked: serializer.fromJson<bool?>(json['isLiked']),
      version: serializer.fromJson<int?>(json['version']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<String>(articleId),
      'title': serializer.toJson<String?>(title),
      'summary': serializer.toJson<String?>(summary),
      'body': serializer.toJson<String?>(body),
      'source': serializer.toJson<String?>(source),
      'authorId': serializer.toJson<String?>(authorId),
      'authorName': serializer.toJson<String?>(authorName),
      'authorAvatar': serializer.toJson<String?>(authorAvatar),
      'authorBio': serializer.toJson<String?>(authorBio),
      'topicId': serializer.toJson<String?>(topicId),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'readTimeMinutes': serializer.toJson<int?>(readTimeMinutes),
      'image': serializer.toJson<String?>(image),
      'gallery': serializer.toJson<String?>(gallery),
      'tags': serializer.toJson<String?>(tags),
      'related': serializer.toJson<String?>(related),
      'likes': serializer.toJson<int?>(likes),
      'comments': serializer.toJson<int?>(comments),
      'isLiked': serializer.toJson<bool?>(isLiked),
      'version': serializer.toJson<int?>(version),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  ArticleEntity copyWith({
    String? articleId,
    Value<String?> title = const Value.absent(),
    Value<String?> summary = const Value.absent(),
    Value<String?> body = const Value.absent(),
    Value<String?> source = const Value.absent(),
    Value<String?> authorId = const Value.absent(),
    Value<String?> authorName = const Value.absent(),
    Value<String?> authorAvatar = const Value.absent(),
    Value<String?> authorBio = const Value.absent(),
    Value<String?> topicId = const Value.absent(),
    Value<DateTime?> publishedAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<int?> readTimeMinutes = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<String?> gallery = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<String?> related = const Value.absent(),
    Value<int?> likes = const Value.absent(),
    Value<int?> comments = const Value.absent(),
    Value<bool?> isLiked = const Value.absent(),
    Value<int?> version = const Value.absent(),
    DateTime? cachedAt,
  }) => ArticleEntity(
    articleId: articleId ?? this.articleId,
    title: title.present ? title.value : this.title,
    summary: summary.present ? summary.value : this.summary,
    body: body.present ? body.value : this.body,
    source: source.present ? source.value : this.source,
    authorId: authorId.present ? authorId.value : this.authorId,
    authorName: authorName.present ? authorName.value : this.authorName,
    authorAvatar: authorAvatar.present ? authorAvatar.value : this.authorAvatar,
    authorBio: authorBio.present ? authorBio.value : this.authorBio,
    topicId: topicId.present ? topicId.value : this.topicId,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    readTimeMinutes: readTimeMinutes.present
        ? readTimeMinutes.value
        : this.readTimeMinutes,
    image: image.present ? image.value : this.image,
    gallery: gallery.present ? gallery.value : this.gallery,
    tags: tags.present ? tags.value : this.tags,
    related: related.present ? related.value : this.related,
    likes: likes.present ? likes.value : this.likes,
    comments: comments.present ? comments.value : this.comments,
    isLiked: isLiked.present ? isLiked.value : this.isLiked,
    version: version.present ? version.value : this.version,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  ArticleEntity copyWithCompanion(ArticlesCompanion data) {
    return ArticleEntity(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      body: data.body.present ? data.body.value : this.body,
      source: data.source.present ? data.source.value : this.source,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      authorAvatar: data.authorAvatar.present
          ? data.authorAvatar.value
          : this.authorAvatar,
      authorBio: data.authorBio.present ? data.authorBio.value : this.authorBio,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      readTimeMinutes: data.readTimeMinutes.present
          ? data.readTimeMinutes.value
          : this.readTimeMinutes,
      image: data.image.present ? data.image.value : this.image,
      gallery: data.gallery.present ? data.gallery.value : this.gallery,
      tags: data.tags.present ? data.tags.value : this.tags,
      related: data.related.present ? data.related.value : this.related,
      likes: data.likes.present ? data.likes.value : this.likes,
      comments: data.comments.present ? data.comments.value : this.comments,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
      version: data.version.present ? data.version.value : this.version,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticleEntity(')
          ..write('articleId: $articleId, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('body: $body, ')
          ..write('source: $source, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName, ')
          ..write('authorAvatar: $authorAvatar, ')
          ..write('authorBio: $authorBio, ')
          ..write('topicId: $topicId, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('readTimeMinutes: $readTimeMinutes, ')
          ..write('image: $image, ')
          ..write('gallery: $gallery, ')
          ..write('tags: $tags, ')
          ..write('related: $related, ')
          ..write('likes: $likes, ')
          ..write('comments: $comments, ')
          ..write('isLiked: $isLiked, ')
          ..write('version: $version, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    articleId,
    title,
    summary,
    body,
    source,
    authorId,
    authorName,
    authorAvatar,
    authorBio,
    topicId,
    publishedAt,
    updatedAt,
    readTimeMinutes,
    image,
    gallery,
    tags,
    related,
    likes,
    comments,
    isLiked,
    version,
    cachedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleEntity &&
          other.articleId == this.articleId &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.body == this.body &&
          other.source == this.source &&
          other.authorId == this.authorId &&
          other.authorName == this.authorName &&
          other.authorAvatar == this.authorAvatar &&
          other.authorBio == this.authorBio &&
          other.topicId == this.topicId &&
          other.publishedAt == this.publishedAt &&
          other.updatedAt == this.updatedAt &&
          other.readTimeMinutes == this.readTimeMinutes &&
          other.image == this.image &&
          other.gallery == this.gallery &&
          other.tags == this.tags &&
          other.related == this.related &&
          other.likes == this.likes &&
          other.comments == this.comments &&
          other.isLiked == this.isLiked &&
          other.version == this.version &&
          other.cachedAt == this.cachedAt);
}

class ArticlesCompanion extends UpdateCompanion<ArticleEntity> {
  final Value<String> articleId;
  final Value<String?> title;
  final Value<String?> summary;
  final Value<String?> body;
  final Value<String?> source;
  final Value<String?> authorId;
  final Value<String?> authorName;
  final Value<String?> authorAvatar;
  final Value<String?> authorBio;
  final Value<String?> topicId;
  final Value<DateTime?> publishedAt;
  final Value<DateTime?> updatedAt;
  final Value<int?> readTimeMinutes;
  final Value<String?> image;
  final Value<String?> gallery;
  final Value<String?> tags;
  final Value<String?> related;
  final Value<int?> likes;
  final Value<int?> comments;
  final Value<bool?> isLiked;
  final Value<int?> version;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const ArticlesCompanion({
    this.articleId = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.body = const Value.absent(),
    this.source = const Value.absent(),
    this.authorId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorAvatar = const Value.absent(),
    this.authorBio = const Value.absent(),
    this.topicId = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.readTimeMinutes = const Value.absent(),
    this.image = const Value.absent(),
    this.gallery = const Value.absent(),
    this.tags = const Value.absent(),
    this.related = const Value.absent(),
    this.likes = const Value.absent(),
    this.comments = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.version = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticlesCompanion.insert({
    required String articleId,
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.body = const Value.absent(),
    this.source = const Value.absent(),
    this.authorId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorAvatar = const Value.absent(),
    this.authorBio = const Value.absent(),
    this.topicId = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.readTimeMinutes = const Value.absent(),
    this.image = const Value.absent(),
    this.gallery = const Value.absent(),
    this.tags = const Value.absent(),
    this.related = const Value.absent(),
    this.likes = const Value.absent(),
    this.comments = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.version = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId);
  static Insertable<ArticleEntity> custom({
    Expression<String>? articleId,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? body,
    Expression<String>? source,
    Expression<String>? authorId,
    Expression<String>? authorName,
    Expression<String>? authorAvatar,
    Expression<String>? authorBio,
    Expression<String>? topicId,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? readTimeMinutes,
    Expression<String>? image,
    Expression<String>? gallery,
    Expression<String>? tags,
    Expression<String>? related,
    Expression<int>? likes,
    Expression<int>? comments,
    Expression<bool>? isLiked,
    Expression<int>? version,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (body != null) 'body': body,
      if (source != null) 'source': source,
      if (authorId != null) 'author_id': authorId,
      if (authorName != null) 'author_name': authorName,
      if (authorAvatar != null) 'author_avatar': authorAvatar,
      if (authorBio != null) 'author_bio': authorBio,
      if (topicId != null) 'topic_id': topicId,
      if (publishedAt != null) 'published_at': publishedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (readTimeMinutes != null) 'read_time_minutes': readTimeMinutes,
      if (image != null) 'image': image,
      if (gallery != null) 'gallery': gallery,
      if (tags != null) 'tags': tags,
      if (related != null) 'related': related,
      if (likes != null) 'likes': likes,
      if (comments != null) 'comments': comments,
      if (isLiked != null) 'is_liked': isLiked,
      if (version != null) 'version': version,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticlesCompanion copyWith({
    Value<String>? articleId,
    Value<String?>? title,
    Value<String?>? summary,
    Value<String?>? body,
    Value<String?>? source,
    Value<String?>? authorId,
    Value<String?>? authorName,
    Value<String?>? authorAvatar,
    Value<String?>? authorBio,
    Value<String?>? topicId,
    Value<DateTime?>? publishedAt,
    Value<DateTime?>? updatedAt,
    Value<int?>? readTimeMinutes,
    Value<String?>? image,
    Value<String?>? gallery,
    Value<String?>? tags,
    Value<String?>? related,
    Value<int?>? likes,
    Value<int?>? comments,
    Value<bool?>? isLiked,
    Value<int?>? version,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return ArticlesCompanion(
      articleId: articleId ?? this.articleId,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      source: source ?? this.source,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      authorBio: authorBio ?? this.authorBio,
      topicId: topicId ?? this.topicId,
      publishedAt: publishedAt ?? this.publishedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      readTimeMinutes: readTimeMinutes ?? this.readTimeMinutes,
      image: image ?? this.image,
      gallery: gallery ?? this.gallery,
      tags: tags ?? this.tags,
      related: related ?? this.related,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      version: version ?? this.version,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (authorAvatar.present) {
      map['author_avatar'] = Variable<String>(authorAvatar.value);
    }
    if (authorBio.present) {
      map['author_bio'] = Variable<String>(authorBio.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (readTimeMinutes.present) {
      map['read_time_minutes'] = Variable<int>(readTimeMinutes.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (gallery.present) {
      map['gallery'] = Variable<String>(gallery.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (related.present) {
      map['related'] = Variable<String>(related.value);
    }
    if (likes.present) {
      map['likes'] = Variable<int>(likes.value);
    }
    if (comments.present) {
      map['comments'] = Variable<int>(comments.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('articleId: $articleId, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('body: $body, ')
          ..write('source: $source, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName, ')
          ..write('authorAvatar: $authorAvatar, ')
          ..write('authorBio: $authorBio, ')
          ..write('topicId: $topicId, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('readTimeMinutes: $readTimeMinutes, ')
          ..write('image: $image, ')
          ..write('gallery: $gallery, ')
          ..write('tags: $tags, ')
          ..write('related: $related, ')
          ..write('likes: $likes, ')
          ..write('comments: $comments, ')
          ..write('isLiked: $isLiked, ')
          ..write('version: $version, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $OutboxMutationsTable outboxMutations = $OutboxMutationsTable(
    this,
  );
  late final $FeedItemsTable feedItems = $FeedItemsTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final BookmarksDao bookmarksDao = BookmarksDao(this as AppDatabase);
  late final OutboxDao outboxDao = OutboxDao(this as AppDatabase);
  late final FeedItemsDao feedItemsDao = FeedItemsDao(this as AppDatabase);
  late final ArticlesDao articlesDao = ArticlesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bookmarks,
    outboxMutations,
    feedItems,
    articles,
  ];
}

typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      required String articleId,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> source,
      Value<String?> topicId,
      Value<String?> authorName,
      Value<String?> authorAvatar,
      Value<String?> image,
      Value<DateTime?> publishedAt,
      Value<DateTime> savedAt,
      Value<bool> isSynced,
      Value<bool> pendingRemoval,
      Value<int> rowid,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<String> articleId,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> source,
      Value<String?> topicId,
      Value<String?> authorName,
      Value<String?> authorAvatar,
      Value<String?> image,
      Value<DateTime?> publishedAt,
      Value<DateTime> savedAt,
      Value<bool> isSynced,
      Value<bool> pendingRemoval,
      Value<int> rowid,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingRemoval => $composableBuilder(
    column: $table.pendingRemoval,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingRemoval => $composableBuilder(
    column: $table.pendingRemoval,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get pendingRemoval => $composableBuilder(
    column: $table.pendingRemoval,
    builder: (column) => column,
  );
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          BookmarkEntity,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (
            BookmarkEntity,
            BaseReferences<_$AppDatabase, $BookmarksTable, BookmarkEntity>,
          ),
          BookmarkEntity,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> articleId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> authorName = const Value.absent(),
                Value<String?> authorAvatar = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> pendingRemoval = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion(
                articleId: articleId,
                title: title,
                summary: summary,
                source: source,
                topicId: topicId,
                authorName: authorName,
                authorAvatar: authorAvatar,
                image: image,
                publishedAt: publishedAt,
                savedAt: savedAt,
                isSynced: isSynced,
                pendingRemoval: pendingRemoval,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String articleId,
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> authorName = const Value.absent(),
                Value<String?> authorAvatar = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> pendingRemoval = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion.insert(
                articleId: articleId,
                title: title,
                summary: summary,
                source: source,
                topicId: topicId,
                authorName: authorName,
                authorAvatar: authorAvatar,
                image: image,
                publishedAt: publishedAt,
                savedAt: savedAt,
                isSynced: isSynced,
                pendingRemoval: pendingRemoval,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BookmarksTable, BookmarkEntity>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BookmarksTable,
                    BookmarkEntity
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      BookmarkEntity,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (
        BookmarkEntity,
        BaseReferences<_$AppDatabase, $BookmarksTable, BookmarkEntity>,
      ),
      BookmarkEntity,
      PrefetchHooks Function()
    >;
typedef $$OutboxMutationsTableCreateCompanionBuilder =
    OutboxMutationsCompanion Function({
      Value<int> id,
      required String idempotencyKey,
      required String op,
      required String articleId,
      required String payload,
      Value<DateTime> createdAt,
      Value<int> attempts,
    });
typedef $$OutboxMutationsTableUpdateCompanionBuilder =
    OutboxMutationsCompanion Function({
      Value<int> id,
      Value<String> idempotencyKey,
      Value<String> op,
      Value<String> articleId,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<int> attempts,
    });

class $$OutboxMutationsTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxMutationsTable> {
  $$OutboxMutationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get op => $composableBuilder(
    column: $table.op,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxMutationsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxMutationsTable> {
  $$OutboxMutationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get op => $composableBuilder(
    column: $table.op,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxMutationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxMutationsTable> {
  $$OutboxMutationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get op =>
      $composableBuilder(column: $table.op, builder: (column) => column);

  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);
}

class $$OutboxMutationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxMutationsTable,
          OutboxEntity,
          $$OutboxMutationsTableFilterComposer,
          $$OutboxMutationsTableOrderingComposer,
          $$OutboxMutationsTableAnnotationComposer,
          $$OutboxMutationsTableCreateCompanionBuilder,
          $$OutboxMutationsTableUpdateCompanionBuilder,
          (
            OutboxEntity,
            BaseReferences<_$AppDatabase, $OutboxMutationsTable, OutboxEntity>,
          ),
          OutboxEntity,
          PrefetchHooks Function()
        > {
  $$OutboxMutationsTableTableManager(
    _$AppDatabase db,
    $OutboxMutationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxMutationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxMutationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxMutationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> op = const Value.absent(),
                Value<String> articleId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
              }) => OutboxMutationsCompanion(
                id: id,
                idempotencyKey: idempotencyKey,
                op: op,
                articleId: articleId,
                payload: payload,
                createdAt: createdAt,
                attempts: attempts,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String idempotencyKey,
                required String op,
                required String articleId,
                required String payload,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attempts = const Value.absent(),
              }) => OutboxMutationsCompanion.insert(
                id: id,
                idempotencyKey: idempotencyKey,
                op: op,
                articleId: articleId,
                payload: payload,
                createdAt: createdAt,
                attempts: attempts,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OutboxMutationsTable, OutboxEntity>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $OutboxMutationsTable,
                    OutboxEntity
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxMutationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxMutationsTable,
      OutboxEntity,
      $$OutboxMutationsTableFilterComposer,
      $$OutboxMutationsTableOrderingComposer,
      $$OutboxMutationsTableAnnotationComposer,
      $$OutboxMutationsTableCreateCompanionBuilder,
      $$OutboxMutationsTableUpdateCompanionBuilder,
      (
        OutboxEntity,
        BaseReferences<_$AppDatabase, $OutboxMutationsTable, OutboxEntity>,
      ),
      OutboxEntity,
      PrefetchHooks Function()
    >;
typedef $$FeedItemsTableCreateCompanionBuilder =
    FeedItemsCompanion Function({
      required String articleId,
      Value<String> feedTopicId,
      required int feedPosition,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> source,
      Value<String?> topicId,
      Value<String?> authorId,
      Value<String?> authorName,
      Value<String?> authorAvatar,
      Value<String?> image,
      Value<String?> tags,
      Value<DateTime?> publishedAt,
      Value<int?> likes,
      Value<int?> comments,
      Value<bool?> isLiked,
      Value<int?> version,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });
typedef $$FeedItemsTableUpdateCompanionBuilder =
    FeedItemsCompanion Function({
      Value<String> articleId,
      Value<String> feedTopicId,
      Value<int> feedPosition,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> source,
      Value<String?> topicId,
      Value<String?> authorId,
      Value<String?> authorName,
      Value<String?> authorAvatar,
      Value<String?> image,
      Value<String?> tags,
      Value<DateTime?> publishedAt,
      Value<int?> likes,
      Value<int?> comments,
      Value<bool?> isLiked,
      Value<int?> version,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$FeedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedTopicId => $composableBuilder(
    column: $table.feedTopicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get feedPosition => $composableBuilder(
    column: $table.feedPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likes => $composableBuilder(
    column: $table.likes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get comments => $composableBuilder(
    column: $table.comments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedTopicId => $composableBuilder(
    column: $table.feedTopicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feedPosition => $composableBuilder(
    column: $table.feedPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likes => $composableBuilder(
    column: $table.likes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get comments => $composableBuilder(
    column: $table.comments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<String> get feedTopicId => $composableBuilder(
    column: $table.feedTopicId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get feedPosition => $composableBuilder(
    column: $table.feedPosition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get likes =>
      $composableBuilder(column: $table.likes, builder: (column) => column);

  GeneratedColumn<int> get comments =>
      $composableBuilder(column: $table.comments, builder: (column) => column);

  GeneratedColumn<bool> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$FeedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedItemsTable,
          FeedItemEntity,
          $$FeedItemsTableFilterComposer,
          $$FeedItemsTableOrderingComposer,
          $$FeedItemsTableAnnotationComposer,
          $$FeedItemsTableCreateCompanionBuilder,
          $$FeedItemsTableUpdateCompanionBuilder,
          (
            FeedItemEntity,
            BaseReferences<_$AppDatabase, $FeedItemsTable, FeedItemEntity>,
          ),
          FeedItemEntity,
          PrefetchHooks Function()
        > {
  $$FeedItemsTableTableManager(_$AppDatabase db, $FeedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> articleId = const Value.absent(),
                Value<String> feedTopicId = const Value.absent(),
                Value<int> feedPosition = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> authorId = const Value.absent(),
                Value<String?> authorName = const Value.absent(),
                Value<String?> authorAvatar = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int?> likes = const Value.absent(),
                Value<int?> comments = const Value.absent(),
                Value<bool?> isLiked = const Value.absent(),
                Value<int?> version = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedItemsCompanion(
                articleId: articleId,
                feedTopicId: feedTopicId,
                feedPosition: feedPosition,
                title: title,
                summary: summary,
                source: source,
                topicId: topicId,
                authorId: authorId,
                authorName: authorName,
                authorAvatar: authorAvatar,
                image: image,
                tags: tags,
                publishedAt: publishedAt,
                likes: likes,
                comments: comments,
                isLiked: isLiked,
                version: version,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String articleId,
                Value<String> feedTopicId = const Value.absent(),
                required int feedPosition,
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<String?> authorId = const Value.absent(),
                Value<String?> authorName = const Value.absent(),
                Value<String?> authorAvatar = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<int?> likes = const Value.absent(),
                Value<int?> comments = const Value.absent(),
                Value<bool?> isLiked = const Value.absent(),
                Value<int?> version = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedItemsCompanion.insert(
                articleId: articleId,
                feedTopicId: feedTopicId,
                feedPosition: feedPosition,
                title: title,
                summary: summary,
                source: source,
                topicId: topicId,
                authorId: authorId,
                authorName: authorName,
                authorAvatar: authorAvatar,
                image: image,
                tags: tags,
                publishedAt: publishedAt,
                likes: likes,
                comments: comments,
                isLiked: isLiked,
                version: version,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedItemsTable, FeedItemEntity>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FeedItemsTable,
                    FeedItemEntity
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedItemsTable,
      FeedItemEntity,
      $$FeedItemsTableFilterComposer,
      $$FeedItemsTableOrderingComposer,
      $$FeedItemsTableAnnotationComposer,
      $$FeedItemsTableCreateCompanionBuilder,
      $$FeedItemsTableUpdateCompanionBuilder,
      (
        FeedItemEntity,
        BaseReferences<_$AppDatabase, $FeedItemsTable, FeedItemEntity>,
      ),
      FeedItemEntity,
      PrefetchHooks Function()
    >;
typedef $$ArticlesTableCreateCompanionBuilder =
    ArticlesCompanion Function({
      required String articleId,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> body,
      Value<String?> source,
      Value<String?> authorId,
      Value<String?> authorName,
      Value<String?> authorAvatar,
      Value<String?> authorBio,
      Value<String?> topicId,
      Value<DateTime?> publishedAt,
      Value<DateTime?> updatedAt,
      Value<int?> readTimeMinutes,
      Value<String?> image,
      Value<String?> gallery,
      Value<String?> tags,
      Value<String?> related,
      Value<int?> likes,
      Value<int?> comments,
      Value<bool?> isLiked,
      Value<int?> version,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });
typedef $$ArticlesTableUpdateCompanionBuilder =
    ArticlesCompanion Function({
      Value<String> articleId,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> body,
      Value<String?> source,
      Value<String?> authorId,
      Value<String?> authorName,
      Value<String?> authorAvatar,
      Value<String?> authorBio,
      Value<String?> topicId,
      Value<DateTime?> publishedAt,
      Value<DateTime?> updatedAt,
      Value<int?> readTimeMinutes,
      Value<String?> image,
      Value<String?> gallery,
      Value<String?> tags,
      Value<String?> related,
      Value<int?> likes,
      Value<int?> comments,
      Value<bool?> isLiked,
      Value<int?> version,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$ArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorBio => $composableBuilder(
    column: $table.authorBio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readTimeMinutes => $composableBuilder(
    column: $table.readTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gallery => $composableBuilder(
    column: $table.gallery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get related => $composableBuilder(
    column: $table.related,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likes => $composableBuilder(
    column: $table.likes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get comments => $composableBuilder(
    column: $table.comments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorBio => $composableBuilder(
    column: $table.authorBio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get readTimeMinutes => $composableBuilder(
    column: $table.readTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gallery => $composableBuilder(
    column: $table.gallery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get related => $composableBuilder(
    column: $table.related,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likes => $composableBuilder(
    column: $table.likes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get comments => $composableBuilder(
    column: $table.comments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authorAvatar => $composableBuilder(
    column: $table.authorAvatar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authorBio =>
      $composableBuilder(column: $table.authorBio, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get readTimeMinutes => $composableBuilder(
    column: $table.readTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get gallery =>
      $composableBuilder(column: $table.gallery, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get related =>
      $composableBuilder(column: $table.related, builder: (column) => column);

  GeneratedColumn<int> get likes =>
      $composableBuilder(column: $table.likes, builder: (column) => column);

  GeneratedColumn<int> get comments =>
      $composableBuilder(column: $table.comments, builder: (column) => column);

  GeneratedColumn<bool> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$ArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTable,
          ArticleEntity,
          $$ArticlesTableFilterComposer,
          $$ArticlesTableOrderingComposer,
          $$ArticlesTableAnnotationComposer,
          $$ArticlesTableCreateCompanionBuilder,
          $$ArticlesTableUpdateCompanionBuilder,
          (
            ArticleEntity,
            BaseReferences<_$AppDatabase, $ArticlesTable, ArticleEntity>,
          ),
          ArticleEntity,
          PrefetchHooks Function()
        > {
  $$ArticlesTableTableManager(_$AppDatabase db, $ArticlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> articleId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> authorId = const Value.absent(),
                Value<String?> authorName = const Value.absent(),
                Value<String?> authorAvatar = const Value.absent(),
                Value<String?> authorBio = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int?> readTimeMinutes = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> gallery = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> related = const Value.absent(),
                Value<int?> likes = const Value.absent(),
                Value<int?> comments = const Value.absent(),
                Value<bool?> isLiked = const Value.absent(),
                Value<int?> version = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesCompanion(
                articleId: articleId,
                title: title,
                summary: summary,
                body: body,
                source: source,
                authorId: authorId,
                authorName: authorName,
                authorAvatar: authorAvatar,
                authorBio: authorBio,
                topicId: topicId,
                publishedAt: publishedAt,
                updatedAt: updatedAt,
                readTimeMinutes: readTimeMinutes,
                image: image,
                gallery: gallery,
                tags: tags,
                related: related,
                likes: likes,
                comments: comments,
                isLiked: isLiked,
                version: version,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String articleId,
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> authorId = const Value.absent(),
                Value<String?> authorName = const Value.absent(),
                Value<String?> authorAvatar = const Value.absent(),
                Value<String?> authorBio = const Value.absent(),
                Value<String?> topicId = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int?> readTimeMinutes = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> gallery = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> related = const Value.absent(),
                Value<int?> likes = const Value.absent(),
                Value<int?> comments = const Value.absent(),
                Value<bool?> isLiked = const Value.absent(),
                Value<int?> version = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesCompanion.insert(
                articleId: articleId,
                title: title,
                summary: summary,
                body: body,
                source: source,
                authorId: authorId,
                authorName: authorName,
                authorAvatar: authorAvatar,
                authorBio: authorBio,
                topicId: topicId,
                publishedAt: publishedAt,
                updatedAt: updatedAt,
                readTimeMinutes: readTimeMinutes,
                image: image,
                gallery: gallery,
                tags: tags,
                related: related,
                likes: likes,
                comments: comments,
                isLiked: isLiked,
                version: version,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ArticlesTable, ArticleEntity>(table),
                  BaseReferences<_$AppDatabase, $ArticlesTable, ArticleEntity>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTable,
      ArticleEntity,
      $$ArticlesTableFilterComposer,
      $$ArticlesTableOrderingComposer,
      $$ArticlesTableAnnotationComposer,
      $$ArticlesTableCreateCompanionBuilder,
      $$ArticlesTableUpdateCompanionBuilder,
      (
        ArticleEntity,
        BaseReferences<_$AppDatabase, $ArticlesTable, ArticleEntity>,
      ),
      ArticleEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$OutboxMutationsTableTableManager get outboxMutations =>
      $$OutboxMutationsTableTableManager(_db, _db.outboxMutations);
  $$FeedItemsTableTableManager get feedItems =>
      $$FeedItemsTableTableManager(_db, _db.feedItems);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
}
