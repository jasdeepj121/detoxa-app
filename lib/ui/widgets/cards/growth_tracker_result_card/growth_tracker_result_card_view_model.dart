import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/new_growth_tracker.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:detoxa/ui/widgets/dialogs/download_report_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GrowthTrackerResultCardViewModel extends BaseViewModel {
  NewGrowthTrackerReport _newGrowthTracker;
  final DeviceStorage _storage = locator<DeviceStorage>();
  final NavigationService _navigationService = locator<NavigationService>();

  void setInitialData(NewGrowthTrackerReport growthTracker) {
    _newGrowthTracker = growthTracker;
  }

  void onCalculatePressed() {
    _navigationService.pop();
  }

  void onSharePressed() {}

  void onDownloadPressed() {
    _navigationService.displayDialog(
      DownloadReportCard(
        childId: _newGrowthTracker.childId,
        reportId: _newGrowthTracker.id,
      ),
      barrierDismissible: false,
    );
  }

  void onCancelPressed() {
    _navigationService.popUntil(ModalRoute.withName(Routes.homePageView));
  }
}
