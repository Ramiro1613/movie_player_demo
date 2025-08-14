import 'package:flutter/material.dart';
import 'package:movie_demo_selector/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  void setUserData(User data) {
    _user = data;
    notifyListeners();
  }

  User? getUserData() {
    return _user;
  }

  void clearUserData() {
    _user = null;
    notifyListeners();
  }
}
