import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/dialogs/errorDialog.dart';
import 'package:detoxa/utils/emailValidator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserRegistrationViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = locator<AuthService>();
  // final RegistrationFormData _registrationFormData;
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passcodeController = TextEditingController();
  TextEditingController otherCountryController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController mciRegController = TextEditingController();
  TextEditingController otherPracticeAreaController = TextEditingController();
  TextEditingController proceduresController = TextEditingController();
  bool termsAgreed = false;

  // List<Country> get countries => _registrationFormData?.countries ?? [];
  // List<String> get states => _authService?.getStates() ?? [];
  // List<String> get cities => _authService?.getCities(selectedState) ?? [];
  // List<PracticeArea> get practiceArea =>
  //     _registrationFormData?.practiceArea ?? [];
  // List<YearsInPractice> get yearsInPractice =>
  //     _registrationFormData?.yearsInPractice ?? [];
  // bool get enableOtherPraticeAreas =>
  //     selectedPracticeArea?.name?.toUpperCase() == "OTHERS";
  // bool get enableOtherCountries =>
  //     selectedCountry?.name?.toUpperCase() == "OTHER";

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

  String qualificationValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Qualification cannot be left blank";
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
      return "Mobile Number cannot be left blank";
    }
    if (value.length != 10) {
      return "Invalid Mobile number";
    }
    return null;
  }

  String passcodeValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Passcode cannot be left blank";
    }
    return null;
  }



  String proceduresValidator(String value) {
    if (value?.isEmpty ?? true) {
      return "Procedures Undertaken cannot be left blank";
    }
    return null;
  }

  void existingUserPressed() {
    _navigationService.pop();
  }

  void fetchFormData() async {
    try {
      setBusy(true);
      // var data = await _authService.fetchRegistrationFormData();
      // _registrationFormData = data;
      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
  }

  void onSubmit() async {
    try {
      if (!formKey.currentState.validate()) {
        return;
      }
      setBusy(true);
      // RegisterUser newUser = RegisterUser(
      //   name: nameController.text,
      //   city: selectedCity,
      //   countryId: selectedCountry.id,
      //   email: emailController.text,
      //   mobile: mobileController.text,
      //   passcode: passcodeController.text,
      //   practiceArea: selectedPracticeArea.name,
      //   otherPracticeArea:
      //       enableOtherPraticeAreas ? otherPracticeAreaController.text : null,
      //   proceduresUndertaken: proceduresController.text,
      //   qualification: qualificationController.text,
      //   state: selectedState,
      //   hospital: hospitalController.text,
      //   mciRegistration: mciRegController.text,
      //   yearsInPractice: selectedYearsInPractice.name,
      //   otherCountry: enableOtherCountries ? otherCountryController.text : null,
      // );
      // bool success = await _authService.userRegistrationValidation(newUser);
      // if (success) {
      //   _navigationService.pushNamed(
      //     Routes.newPasswordView,
      //     arguments: NewPasswordViewArguments(newUser),
      //   );
      // }
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

  void onTermsOfUsePressed() {
    // StaticPageDatum data = _authService.staticPages
    //     .firstWhere((e) => e.title == "Terms Of Use", orElse: () => null);
    // if (data != null) {
    //   _navigationService.pushNamed(Routes.staticPageView, arguments: data);
    // }
  }
}
