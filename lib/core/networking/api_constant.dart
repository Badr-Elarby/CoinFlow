import 'package:team_7/core/networking/api_secrets.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.coingecko.com/api/v3/';
  static String global = '/global';
  static const String trending = '/search/trending';
  static const String markets = '/coins/markets';
  static String get apiKey => ApiSecrets.apiKey;
}
