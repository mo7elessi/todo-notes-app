import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData(
      {required String key, required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static Future<bool> clearData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }
}
