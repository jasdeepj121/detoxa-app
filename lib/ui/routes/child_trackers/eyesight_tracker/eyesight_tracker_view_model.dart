import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class EyesightTrackerViewModel extends BaseViewModel {
  final DeviceStorage _storage = locator<DeviceStorage>();
  final NavigationService _navigationService = locator<NavigationService>();

  void addImagesToCache(context) {
    try {
      List<String> assetsPath = [];
      for (int i = 1; i <= 18; i++) {
        assetsPath.add(
          "assets/images/trackers/eyesight_tracker/color_blindness-${i.toString()}.png",
        );
      }
      Future.wait(assetsPath.map(
        (e) => precacheImage(AssetImage(e), context),
      ));
    } catch (e) {
      print(e.toString());
    }
  }

  void onColorBlindnessPressed() {
    _navigationService.pushNamed(Routes.colorBlindnessTestView);
  }
}
