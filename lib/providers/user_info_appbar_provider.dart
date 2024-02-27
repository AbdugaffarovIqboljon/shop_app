import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/services/database/user_database.dart';

class UserInfoProvider extends ChangeNotifier {
  late StreamSubscription<Map<String, String>> _streamSubscription;
  Map<String, String> _userData = {};

  UserInfoProvider() {
    _streamSubscription = UserInfoDatabase.userInfoStream
        .listen((userData) => setUserInfo(userData));

    UserInfoDatabase.getUserInfo().then((userInfo) {
      if (userInfo != null) {
        setUserInfo(userInfo);
      }
    });
  }

  Map<String, String> get userData => _userData;

  void setUserInfo(Map<String, String> userInfo) {
    _userData = userInfo;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
