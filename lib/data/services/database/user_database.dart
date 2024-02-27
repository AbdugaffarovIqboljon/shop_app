import 'dart:async';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfoDatabase {
  static const String _keyName = 'user_name';
  static const String _keyEmail = 'user_email';
  static const String _keyUserId = 'user_id';

  static final StreamController<Map<String, String>> _userInfoController =
      StreamController<Map<String, String>>.broadcast();

  static Future<void> saveUserInfo(String name, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Random random = Random();

    /// #Generated User ID
    final String userId = DateTime.now().millisecondsSinceEpoch.toString() +
        random.nextInt(1000).toString();

    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);

    _userInfoController.add({'userId': userId, 'name': name, 'email': email});
  }

  static Future<Map<String, String>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString(_keyName);
    final String? email = prefs.getString(_keyEmail);
    if (name != null && email != null) {
      return {'name': name, 'email': email};
    }
    return null;
  }

  static Future<void> deleteUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(_keyName) && prefs.containsKey(_keyEmail)) {
      await prefs.remove(_keyName);
      await prefs.remove(_keyEmail);
      await prefs.remove(_keyUserId);

      _userInfoController.add({
        'name': '',
        'email': '',
        'userID': '',
      });
    }
  }

  static Stream<Map<String, String>> get userInfoStream =>
      _userInfoController.stream;
}
