import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GrowthTrackerResultCardViewModel extends BaseViewModel {
  final DeviceStorage _storage = locator<DeviceStorage>();
  final NavigationService _navigationService = locator<NavigationService>();

  void onCalculatePressed() {}

  void onSharePressed() {}

  void onDownloadPressed() {}

  void onCancelPressed() {
    _navigationService.pop();
  }
}
