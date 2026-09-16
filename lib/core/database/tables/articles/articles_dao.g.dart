// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_dao.dart';

// ignore_for_file: type=lint
mixin _$ArticlesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ArticlesTable get articles => attachedDatabase.articles;
  ArticlesDaoManager get managers => ArticlesDaoManager(this);
}

class ArticlesDaoManager {
  final _$ArticlesDaoMixin _db;
  ArticlesDaoManager(this._db);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db.attachedDatabase, _db.articles);
}
