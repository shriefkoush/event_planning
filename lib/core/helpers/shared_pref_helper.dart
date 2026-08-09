import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static setData(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return null;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key :');
    return await flutterSecureStorage.read(key: key) ?? '';
  }
  static clearAllSecuredData() async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : All data has been cleared ');
    await flutterSecureStorage.deleteAll();
  }

  // --- Session Management Keys & Helpers ---
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keySessionExpiration = 'session_expiration_timestamp';
  static const String _keyUserToken = 'user_auth_token';

  /// Saves the user authentication session with a 20-day expiration window.
  static Future<void> saveUserSession({
    required String tokenOrUid,
    int sessionDurationDays = 20,
  }) async {
    try {
      final int expirationMillis = DateTime.now()
          .add(Duration(days: sessionDurationDays))
          .millisecondsSinceEpoch;

      await setData(_keyIsLoggedIn, true);
      await setData(_keySessionExpiration, expirationMillis);
      await setSecuredString(_keyUserToken, tokenOrUid);

      debugPrint(
        'SharedPrefHelper: User session saved successfully. Expires at: ${DateTime.fromMillisecondsSinceEpoch(expirationMillis)}',
      );
    } catch (e) {
      debugPrint('SharedPrefHelper: Error saving user session: $e');
      rethrow;
    }
  }

  /// Checks whether the user has a valid, unexpired session.
  static Future<bool> isSessionValid() async {
    try {
      final bool isLoggedIn = await getBool(_keyIsLoggedIn);
      if (!isLoggedIn) {
        debugPrint('SharedPrefHelper: Session check failed - isLoggedIn is false');
        return false;
      }

      final String token = await getSecuredString(_keyUserToken);
      if (token.isEmpty) {
        debugPrint('SharedPrefHelper: Session check failed - token is empty');
        return false;
      }

      final int expirationMillis = await getInt(_keySessionExpiration);
      if (expirationMillis <= 0) {
        debugPrint('SharedPrefHelper: Session check failed - invalid expiration timestamp');
        return false;
      }

      final int nowMillis = DateTime.now().millisecondsSinceEpoch;
      if (nowMillis >= expirationMillis) {
        debugPrint('SharedPrefHelper: Session check failed - session expired');
        await clearUserSession();
        return false;
      }

      debugPrint('SharedPrefHelper: Session check passed - valid session until ${DateTime.fromMillisecondsSinceEpoch(expirationMillis)}');
      return true;
    } catch (e) {
      debugPrint('SharedPrefHelper: Error validating session: $e');
      await clearUserSession();
      return false;
    }
  }

  /// Clears all stored authentication and session data.
  static Future<void> clearUserSession() async {
    try {
      await removeData(_keyIsLoggedIn);
      await removeData(_keySessionExpiration);
      const flutterSecureStorage = FlutterSecureStorage();
      await flutterSecureStorage.delete(key: _keyUserToken);
      debugPrint('SharedPrefHelper: User session cleared successfully');
    } catch (e) {
      debugPrint('SharedPrefHelper: Error clearing user session: $e');
    }
  }
}