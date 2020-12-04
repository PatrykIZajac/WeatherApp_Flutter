import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  static const kelvin = '0';
  static const fahrenheit = '1';
  static const celsius = '2';
  static const unit_km = 'km/h';
  static const unit_mph = 'mph';
  static const unit_hpa = 'hpa';
  static const unit_psi = 'psi';

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setMeasureUnit(String value) {
    return _prefs.setString('measure', value);
  }

  String getMeasureUnit() {
    return _prefs.getString('measure') ?? '0';
  }

  Future<bool> setLang(String value) {
    return _prefs.setString('lang', value);
  }

  String getLang() {
    return _prefs.getString('lang') ?? 'en';
  }

  Future<bool> setSpeedUnit(String value) {
    return _prefs.setString('speedUnit', value);
  }

  String getSpeedUnit() {
    return _prefs.getString('speedUnit') ?? 'km/h';
  }

  Future<bool> setPressureUnit(String value) {
    return _prefs.setString('pressureUnit', value);
  }

  String getPressureUnit() {
    return _prefs.getString('pressureUnit') ?? 'hpa';
  }

  Future<bool> setDarkMode(String value) {
    return _prefs.setString('darkMode', value);
  }

  String getDarkMode() {
    return _prefs.getString('darkMode') ?? 'false';
  }
}
