import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static Future<bool> saveString(
      {required String key, required String value}) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<bool> saveMap(
      {required String key, required Map<String, dynamic> value}) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, jsonEncode(value));
  }

  static Future<String> getString({required String key}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? '';
  }

  static Future<Map<String, dynamic>> getMap({required String key}) async {
    try {
      return jsonDecode(await getString(key: key));
    } catch (_) {
      return {};
    }
  }

  static Future<bool> remove({required String key}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
