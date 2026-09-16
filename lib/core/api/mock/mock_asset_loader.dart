import 'dart:convert';

import 'package:flutter/services.dart';

class MockAssetLoader {
  MockAssetLoader({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  static const String root = 'json_data';

  final AssetBundle _bundle;
  final Map<String, dynamic> _cache = {};

  Future<dynamic> load(String relativePath) async {
    final cached = _cache[relativePath];
    if (cached != null) return cached;
    final raw = await _bundle.loadString('$root/$relativePath');
    final decoded = jsonDecode(raw);
    _cache[relativePath] = decoded;
    return decoded;
  }

  Future<Map<String, dynamic>> loadMap(String relativePath) async =>
      Map<String, dynamic>.from(await load(relativePath) as Map);

  Future<List<Map<String, dynamic>>> loadList(String relativePath) async =>
      (await load(relativePath) as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
}
