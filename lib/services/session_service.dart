import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> login(String username) async {
    await _prefs.setString('username', username);
    await _prefs.setBool('isLoggedIn', true);
  }

  static Future<void> logout() async {
    await _prefs.remove('username');
    await _prefs.setBool('isLoggedIn', false);
  }

  static bool isLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  static String getUsername() {
    return _prefs.getString('username') ?? '';
  }
}