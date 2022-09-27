import 'package:city_navigation/models/user.dart';
import 'package:flutter/cupertino.dart';

class AppData with ChangeNotifier {
  bool userInitialised = false;
  late User user;

  void setUser(User user) {
    this.user = user;
    userInitialised = true;
    notifyListeners();
  }
}
