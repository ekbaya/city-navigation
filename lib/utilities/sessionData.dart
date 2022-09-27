import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<String?> getCurrentUserToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }
}
