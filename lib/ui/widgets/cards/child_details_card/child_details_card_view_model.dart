import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/cards/add_new_child/add_new_child_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChildDetailsCardViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  List children;
  var _selectedChild;
  final List<String> _genderList = ["Male", "Female"];
  String _selectedGender;

  String get selectedChild => _selectedChild;
  List<String> get genderList => _genderList;
  String get selectedGender => _selectedGender ?? _genderList.first;

  ChildDetailsCardViewModel() {
    //fetch children's name
  }

  void onAddChildPressed() {
    _navigationService.displayDialog(
      const AddNewChildCard(),
      barrierDismissible: false,
    );
  }

  void onGenerateReportPressed() {}

  void onGenderChanged(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void childChanged() {}
}
