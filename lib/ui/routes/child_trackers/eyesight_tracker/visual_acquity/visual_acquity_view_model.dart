import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/dialogs/error_dialog.dart';
import 'package:stacked/stacked.dart';

class VisualAcquityTestViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLeftEyeSelected;
  int leftEyeAnswer;
  int rightEyeAnswer;

  void onLeftEyeSelected() {
    isLeftEyeSelected = true;
    notifyListeners();
  }

  void onRightEyeSelected() {
    isLeftEyeSelected = false;
    notifyListeners();
  }

  int getSelectedOption() {
    if (isLeftEyeSelected == null) return null;
    if (isLeftEyeSelected) {
      return leftEyeAnswer;
    }
    return rightEyeAnswer;
  }

  void lineSelected(int lineNumber) {
    if (isLeftEyeSelected == null) {
      _navigationService.displayDialog(ErrorDialog(
        message: "Please choose the eye first",
      ));
      return;
    }
    if (isLeftEyeSelected) {
      leftEyeAnswer = lineNumber;
    } else {
      rightEyeAnswer = lineNumber;
    }
    notifyListeners();
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
