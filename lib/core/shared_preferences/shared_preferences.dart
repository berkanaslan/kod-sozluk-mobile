import 'dart:convert';

import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    // We deleted the before user data because of we don't hold sessions.
    removeUserData();
  }

  // -------------------------------------------------------------------------------------------------------------------
  // USER                                                                                                              /
  // -------------------------------------------------------------------------------------------------------------------
  static const String _userKey = "user";

  static Future<void> setUser(User user) async {
    _memoryPrefs[_userKey] = jsonEncode(user);
    await _sharedPrefs!.setString(_userKey, jsonEncode(user));
  }

  static User? getUser() {
    String? userMap;
    User? user;

    if (_memoryPrefs.containsKey(_userKey)) {
      userMap = _sharedPrefs!.getString(_userKey);
      if (userMap != null) user = User.fromJson(json.decode(userMap) as Map<String, dynamic>);
    }

    if (user == null) {
      userMap = _sharedPrefs!.getString(_userKey);
      if (userMap != null) user = User.fromJson(json.decode(userMap) as Map<String, dynamic>);
    }

    return user;
  }

  // -------------------------------------------------------------------------------------------------------------------
  // PRIMITIVE SHARED PREFERENCES HELPER                                                                               /
  // -------------------------------------------------------------------------------------------------------------------

  // String
  static void setString(String key, String value) {
    _memoryPrefs[key] = value;
    _sharedPrefs!.setString(key, value);
  }

  static String? getString(String key, {String? defaultValue}) {
    String? value;

    if (_memoryPrefs.containsKey(key)) value = _memoryPrefs[key] as String;

    value ??= _sharedPrefs!.getString(key);
    value ??= defaultValue;

    return value;
  }

  // Int
  static void setInt(String key, int value) {
    _memoryPrefs[key] = value;
    _sharedPrefs!.setInt(key, value);
  }

  static int? getInt(String key, {int? defaultValue}) {
    int? value;

    if (_memoryPrefs.containsKey(key)) value = _memoryPrefs[key] as int;

    value ??= _sharedPrefs!.getInt(key);
    value ??= defaultValue;

    return value;
  }

  // Bool
  static void setBool(String key, {required bool value}) {
    _memoryPrefs[key] = value;
    _sharedPrefs!.setBool(key, value);
  }

  static bool? getBool(String key, {bool? defaultValue = false}) {
    bool? value;

    if (_memoryPrefs.containsKey(key)) value = _memoryPrefs[key] as bool;

    value ??= _sharedPrefs!.getBool(key);

    value ??= defaultValue;

    return value;
  }

  // Double
  static void setDouble(String key, double value) {
    _memoryPrefs[key] = value;
    _sharedPrefs!.setDouble(key, value);
  }

  static double? getDouble(String key, {double? defaultValue}) {
    double? value;

    if (_memoryPrefs.containsKey(key)) value = _memoryPrefs[key] as double;

    value ??= _sharedPrefs!.getDouble(key);

    value ??= defaultValue;

    return value;
  }

  static Future<void> remove(String key) async {
    // From memory prefs:
    await _memoryPrefs.remove(key);

    // From shared prefs::
    await _sharedPrefs!.remove(key);
  }

  // Remove user data before log-out etc.
  static Future<void> removeUserData() async {
    // From memory prefs:
    await _memoryPrefs.remove(_userKey);

    // From shared prefs::
    await _sharedPrefs!.remove(_userKey);
  }
}
