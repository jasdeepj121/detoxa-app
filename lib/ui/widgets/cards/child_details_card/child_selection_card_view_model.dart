import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/child.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/cards/add_new_child/add_new_child_view.dart';
import 'package:detoxa/ui/widgets/cards/growth_tracker_result_card/growth_tracker_result_card_view.dart';
import 'package:stacked/stacked.dart';

class ChildSelectionCardViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  List<Child> _children;
  Child _selectedChild;
  String errorMessage = "";
  Function(Child) callback;
  // final List<String> _genderList = ["Male", "Female"];
  // String _selectedGender;

  Child get selectedChild => _selectedChild;
  // List<String> get genderList => _genderList;
  // String get selectedGender => _selectedGender ?? _genderList.first;
  List<Child> get childList => _children ?? [];

  ChildSelectionCardViewModel() {
    _authService.getChildList().then((_) {
      _children = _authService.childList.value;
      notifyListeners();
    });
  }

  void setInitialData({Function(Child) onPressed}) {
    callback = onPressed;
  }

  void onAddChildPressed() {
    _navigationService
        .displayDialog(
      const AddNewChildCard(),
      barrierDismissible: false,
    )
        .then((value) {
      if (value ?? false) {
        _authService.getChildList().then((_) {
          _selectedChild = null;
          notifyListeners();
          _children = _authService.childList.value;
          notifyListeners();
        });
      }
    });
  }

  void onGenerateReportPressed() async {
    if (_selectedChild == null) {
      errorMessage = "Please select a child";
      notifyListeners();
      return;
    }
    callback(_selectedChild);
  }

  // void onGenderChanged(String gender) {
  //   _selectedGender = gender;
  //   notifyListeners();
  // }

  void childChanged(Child child) {
    _selectedChild = child;
    errorMessage = "";
    notifyListeners();
  }
}
