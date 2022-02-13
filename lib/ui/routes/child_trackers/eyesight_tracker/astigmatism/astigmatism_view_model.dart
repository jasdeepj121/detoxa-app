import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/dialogs/error_dialog.dart';
import 'package:stacked/stacked.dart';

class AstigmatismTestViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLeftEyeSelected;
  bool leftEyeAnswer;
  bool rightEyeAnswer;

  void onLeftEyeSelected() {
    isLeftEyeSelected = true;
    notifyListeners();
  }

  void onRightEyeSelected() {
    isLeftEyeSelected = false;
    notifyListeners();
  }

  void onYesSelected() {
    if (isLeftEyeSelected == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please choose the eye first",
      ));
      return;
    }
    if (isLeftEyeSelected) {
      leftEyeAnswer = true;
    } else {
      rightEyeAnswer = true;
    }
    notifyListeners();
  }

  void onNoSelected() {
    if (isLeftEyeSelected == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please choose the eye first",
      ));
      return;
    }
    if (isLeftEyeSelected) {
      leftEyeAnswer = false;
    } else {
      rightEyeAnswer = false;
    }
    notifyListeners();
  }

  bool getSelectedOption() {
    if (isLeftEyeSelected == null) return null;
    if (isLeftEyeSelected) {
      return leftEyeAnswer;
    }
    return rightEyeAnswer;
  }

  void onConfirmPressed() {
    if (leftEyeAnswer == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please select the option for left eye",
      ));
      return;
    }
    if (rightEyeAnswer == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please select the option for right eye",
      ));
      return;
    }
  }
}
