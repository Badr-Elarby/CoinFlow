import 'package:hive_ce_flutter/adapters.dart';

class HiveHelper {
  static final HiveHelper _instance = HiveHelper._internal();
  factory HiveHelper() => _instance;
  HiveHelper._internal();

  static const String appBoxKey = 'tmg_drop_box';
  Box<dynamic>? _appBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _appBox = await Hive.openBox(appBoxKey);
  }

  Box<dynamic> get appBox => _appBox!;

  Future<void> cacheResponse(String key, dynamic data) async {
    await _appBox!.put(key, {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  dynamic getCachedResponse(String key) {
    final cached = _appBox!.get(key);
    if (cached == null) return null;
    return cached['data'];
  }

  bool isCacheValid(
    String key, {
    Duration validDuration = const Duration(minutes: 5),
  }) {
    final cached = _appBox!.get(key);
    if (cached == null) return false;

    final timestamp = cached['timestamp'] as int;
    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    return now.difference(cachedTime) < validDuration;
  }

  Future<void> deleteCache(String key) async {
    await _appBox!.delete(key);
  }

  Future<void> clear() async {
    await _appBox!.clear();
  }

  bool hasKey(String key) => _appBox!.containsKey(key);
}
