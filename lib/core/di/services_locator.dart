import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_7/core/cache/hive/hive_helper.dart';
import 'package:team_7/core/cache/secure_storage/secure_storge.dart';
import 'package:team_7/core/networking/dio_factory.dart';

import '../cache/preferences_storage/preferences_storage.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    _initFlutterSecureStorage();

    await _initSharedPreferencesStorage();

    _initDioService();


    await _initHiveHelper(); 

  }

  Future<void> _initSharedPreferencesStorage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => PreferencesStorage(sharedPreferences));
  }

  void _initFlutterSecureStorage() {
    final secureStorage = FlutterSecureStorage();
    sl.registerLazySingleton(() => SecureStorage(secureStorage));
  }


  void _initDioService() {
    sl.registerLazySingleton(() => DioFactory.getDio());
  }

  Future<void> _initHiveHelper() async {
    final hiveHelper = HiveHelper();
    await hiveHelper.init();

    sl.registerLazySingleton(() => hiveHelper);

  
  }

}