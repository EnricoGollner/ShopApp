import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get baseUrlAuth => _get('baseUrlAuth');
  static String get apiKey => _get('API_KEY');
  static String get baseUrl => _get('baseUrl');
  
  static String _get(String name) => dotenv.env[name] ?? '';
}