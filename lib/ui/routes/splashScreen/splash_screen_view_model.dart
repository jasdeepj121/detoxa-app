import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends BaseViewModel {
  final DeviceStorage _storage = locator<DeviceStorage>();
  final NavigationService _navigationService = locator<NavigationService>();

  void nextScreen() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // if ((_storage.accessToken ?? "").isEmpty) {
    //   _navigationService.pushReplacementNamed(Routes.loginView);
    // } else {
    //   _navigationService.pushReplacementNamed(Routes.tabRoute);
    // }
  }
}
