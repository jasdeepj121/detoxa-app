import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/dialogs/error_dialog.dart';
import 'package:detoxa/ui/widgets/dialogs/info_dialog.dart';
import 'package:detoxa/utils/email_validator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserRegistrationViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool termsAgreed = false;

  void onTermAgreedChanged(bool val) {
    termsAgreed = val;
    notifyListeners();
  }

  String nameValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Full Name cannot be left blank";
    }
    if (value.length < 2) {
      return "Invalid Name";
    }
    return null;
  }

  String emailValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Email cannot be left blank";
    }
    if (!(EmailValidator.validate(value))) {
      return "Invalid Email";
    }
    return null;
  }

  String mobileValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Mobile number cannot be left blank";
    }
    if (value.length != 10) {
      return "Invalid Mobile number";
    }
    return null;
  }

  String passwordValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Password cannot be left blank";
    }
    if (value.length <= 4) {
      return "Password should be longer than 4 characters";
    }
    return null;
  }

  void onSubmit() async {
    try {
      if (!formKey.currentState.validate()) {
        return;
      }
      setBusy(true);
      bool success = await _authService.registerUser(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        phone: mobileController.text.trim(),
        password: passwordController.text.trim(),
        termsAccepted: termsAgreed,
      );
      if (success) {
        _navigationService
            .displayDialog(InfoDialog(message: "Successfully registered"))
            .then((_) => _navigationService.pop());
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      String message;
      if (e is DioError) {
        message = e.response.data["message"];
      }
      if (e is Response) {
        var da = (e.data["error"] as Map);
        message = da.values.first.first;
      }
      _navigationService.displayDialog(ErrorDialog(message: message));
    }
  }

  void onPrivacyPolicyPressed() {
    // StaticPageDatum data = _authService.staticPages
    //     .firstWhere((e) => e.title == "Privacy Policy", orElse: () => null);
    // if (data != null) {
    //   _navigationService.pushNamed(Routes.staticPageView, arguments: data);
    // }
  }
}
