import 'package:team_7/core/networking/api_secrets.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.coingecko.com/api/v3/';
  static const String coins = '/global';
  static const String markets = '/coins/markets';
  static const String trending = '/search/trending';
  static const String simplePrice = '/simple/price';
  static const String coinsList = '/coins/list';

  static String coinDetails(String coinId) => '/coins/$coinId';
  static String marketChart(String coinId) => '/coins/$coinId/market_chart';

  static String get apiKey => ApiSecrets.apiKey;
}
