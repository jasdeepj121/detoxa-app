import 'package:detoxa/app/locator/locator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DeviceStorageServiceAbstract {
  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();
}

@lazySingleton
class DeviceStorage {
  SharedPreferences _prefs;

  DeviceStorage() {
    _prefs = locator<SharedPreferences>();
  }

  Future<bool> setAccessToken(String token) {
    return _prefs.setString("accessToken", token);
  }

  String get accessToken => _prefs.getString("accessToken");

  Future<bool> clearData() {
    return _prefs.clear();
  }
}
