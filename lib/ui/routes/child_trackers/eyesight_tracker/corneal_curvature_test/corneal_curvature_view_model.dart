import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/dialogs/error_dialog.dart';
import 'package:stacked/stacked.dart';

class CornealCurvatureTestViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLeftEyeSelected = true;
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
  }

  void onConfirmPressed() {
    if (leftEyeAnswer == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please select the option for left eye",
      ));
    }
    if (rightEyeAnswer == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please select the option for right eye",
      ));
    }
  }
}
