import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum BaseSharePreferenceKey {
  isFirstTime,
  localeCode,
  id,
}

extension _BaseSharePreferenceKeyStr on BaseSharePreferenceKey {
  String get sharedPrefsKey {
    switch (this) {
      case BaseSharePreferenceKey.isFirstTime:
        return 'IS_FIRST_TIME';
      case BaseSharePreferenceKey.localeCode:
        return 'LOCALE_CODE';
      case BaseSharePreferenceKey.id:
        return 'ID';
      default:
        assert(false);
    }

    return '';
  }
}

@Singleton()
class BaseSharedPreference {
  final SharedPreferences _preferences;

  BaseSharedPreference(this._preferences);

  bool? getBool(BaseSharePreferenceKey sharedPreferenceKey) =>
      _preferences.getBool(sharedPreferenceKey.sharedPrefsKey);

  int? getInt(BaseSharePreferenceKey sharedPreferenceKey) =>
      _preferences.getInt(sharedPreferenceKey.sharedPrefsKey);

  double? getDouble(BaseSharePreferenceKey sharedPreferenceKey) =>
      _preferences.getDouble(sharedPreferenceKey.sharedPrefsKey);

  String? getString(BaseSharePreferenceKey sharedPreferenceKey) =>
      _preferences.getString(sharedPreferenceKey.sharedPrefsKey);

  Future<bool>? setBool(
    BaseSharePreferenceKey sharedPreferenceKey,
    bool value,
  ) =>
      _preferences.setBool(sharedPreferenceKey.sharedPrefsKey, value);

  Future<bool>? setInt(BaseSharePreferenceKey sharedPreferenceKey, int value) =>
      _preferences.setInt(sharedPreferenceKey.sharedPrefsKey, value);

  Future<bool>? setDouble(
    BaseSharePreferenceKey sharedPreferenceKey,
    double value,
  ) =>
      _preferences.setDouble(sharedPreferenceKey.sharedPrefsKey, value);

  Future<bool>? setString(
    BaseSharePreferenceKey sharedPreferenceKey,
    String value,
  ) =>
      _preferences.setString(sharedPreferenceKey.sharedPrefsKey, value);

  Future<bool>? remove(BaseSharePreferenceKey sharedPreferenceKey) =>
      _preferences.remove(sharedPreferenceKey.sharedPrefsKey);

  Future<bool>? clear() => _preferences.clear();
}
