import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<bool> saveString(String key, String value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    return saveString(key, json.encode(value));
  }

  static Future<String> loadString(String key) async {
    final sp = await SharedPreferences.getInstance();
    return Future.value(sp.getString(key));
  }

  static Future<Map<String, dynamic>> loadMap(String key) async {
    final value = await loadString(key);
    final Map<String, dynamic> response =
        (value == null || value.isEmpty) ? const {} : json.decode(value);
    return Future.value(response);
  }

  static Future<bool> delete(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }
}
