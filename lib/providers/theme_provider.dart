import 'package:first_app/local_storage/user_preferences.dart';
import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  bool _dark = true;

  ThemeProvider() {
    this._dark = UserPreferences().getDarkMode() == 'true';
  }

  bool get dark => _dark;

  void setLight(bool value) {
    _dark = value;
    notifyListeners();
  }
}
