import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EyesightTrackerViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void addImagesToCache(context) {
    try {
      List<String> assetsPath = [
        "assets/images/trackers/eyesight_tracker/Test-astimatisme.png",
        "assets/images/trackers/eyesight_tracker/visual_acquity.png",
        "assets/images/trackers/eyesight_tracker/curvature.png",
      ];
      for (int i = 1; i <= 18; i++) {
        assetsPath.add(
          "assets/images/trackers/eyesight_tracker/color_blindness-${i.toString()}.png",
        );
      }
      for (int i = 1; i <= 12; i++) {
        assetsPath.add(
          "assets/images/trackers/eyesight_tracker/dry_eye_${i.toString()}.png",
        );
      }
      Future.wait(assetsPath.map(
        (e) => precacheImage(AssetImage(e), context),
      ));
    } catch (_) {}
  }

  void onColorBlindnessPressed() {
    _navigationService.pushNamed(Routes.colorBlindnessTestView);
  }

  void onDryEyePressed() {
    _navigationService.pushNamed(Routes.dryEyeTestView);
  }

  void onCornealCurvaturePressed() {
    _navigationService.pushNamed(Routes.cornealCurvatureTestView);
  }

  void onAstigmatismPressed() {
    _navigationService.pushNamed(Routes.astigmatismTestView);
  }

  void onVisualAcquityPressed() {
    _navigationService.pushNamed(Routes.visualAcquityTestView);
  }
}
