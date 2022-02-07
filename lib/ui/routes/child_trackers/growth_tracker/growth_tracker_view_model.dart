import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/child.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:detoxa/ui/widgets/cards/growth_tracker_result_card/growth_tracker_result_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class GrowthTrackerViewModel extends BaseViewModel {
  final DeviceStorage _storage = locator<DeviceStorage>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController weightController;
  TextEditingController heightController;
  TextEditingController ageController;
  final int maxWeight = 100;
  final int minWeight = 1;
  final int maxAge = 18;
  final int minAge = 1;
  final int maxHeight = 200;
  final int minHeight = 30;

  double weightValue;
  double heightValue;
  double ageValue;

  GrowthTrackerViewModel() {
    weightValue = minWeight.toDouble();
    heightValue = minHeight.toDouble();
    ageValue = minAge.toDouble();
    weightController = TextEditingController(text: minWeight.toString());
    heightController = TextEditingController(text: minHeight.toString());
    ageController = TextEditingController(text: minAge.toString());

    // weightController.addListener(() {
    //   if ((weightController?.text ?? "").isEmpty) return;
    //   int weight = int.tryParse(weightController.text);
    //   if (weight == null) return;
    //   if (weight == maxWeight) return;
    //   if (weight >= minWeight && weight < maxWeight) {
    //     weightValue = weight.toDouble();
    //     notifyListeners();
    //   }
    //   if (weight > maxWeight) {
    //     // weightController.value = TextEditingValue(
    //     //     text: maxWeight.toString(),
    //     //     selection: TextSelection(
    //     //         baseOffset: maxWeight.toString().length,
    //     //         extentOffset: maxWeight.toString().length,
    //     //         affinity: TextAffinity.downstream,
    //     //         isDirectional: false),
    //     //     composing: TextRange(start: 0, end: maxWeight.toString().length));
    //     weightController.text = maxWeight.toString();
    //   }
    //   print("new Weight: ${weightController.text}");
    // });
  }

  void onWeightChanged(double val) {
    weightValue = val;
    weightController.text = val.toInt().toString();
    notifyListeners();
  }

  void onHeightChanged(double val) {
    heightValue = val;
    heightController.text = val.toInt().toString();
    notifyListeners();
  }

  void onAgeChanged(double val) {
    ageValue = val;
    ageController.text = val.toInt().toString();
    notifyListeners();
  }

  // void onWeightTextChanged() {}

  @override
  void dispose() {
    super.dispose();
    weightController?.dispose();
    heightController?.dispose();
    ageController?.dispose();
  }

  void onGeneratePressed(Child child) {
    try {
      setBusy(true);
      // _navigationService.pop();
      _navigationService.displayDialog(GrowthTrackerResultCardView(
        child: child,
        age: ageController.text.trim(),
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
      ));
      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
  }
}
