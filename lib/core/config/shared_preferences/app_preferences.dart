import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isAuthenticated {
    return _prefs.getBool('isAuthenticated') ?? false;
  }

  set isAuthenticated(bool value) {
    _prefs.setBool('isAuthenticated', value);
  }
}
