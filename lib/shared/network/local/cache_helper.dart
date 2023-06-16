// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) =>
      sharedPreferences!.get(key);

  static Future<bool> removeData({
    required String key,
  }) async =>
      await sharedPreferences!.remove(key);
}
