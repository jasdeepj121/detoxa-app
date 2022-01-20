import 'dart:async';
import 'dart:io';
import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/dialogs/errorDialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final _formKey = GlobalKey<FormState>();
  bool _loginUsingOTPenabled = true;
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Timer _otpTimer;
  final int _waitingDurationInSeconds = 120;
  int _resendCounterValue;
  int _otpGeneratedForNumber;

  bool passwordObscured = true;
  int mobileNumberLength = 10;
  int otpLength;

  LoginViewModel() {
    otpLength = _authService.otpLength;
  }

  TextEditingController get mobileController => _mobileController;
  TextEditingController get otpController => _otpController;
  TextEditingController get passwordController => _passwordController;

  bool get loginUsingOTPenabled => _loginUsingOTPenabled;
  bool get timerActive => _otpTimer?.isActive ?? false;
  bool get otpGenerated => _otpTimer != null;

  int get otpTimeRemaining => _resendCounterValue;

  GlobalKey<FormState> get formKey => _formKey;

  void loginUsingOtp(bool val) {
    _loginUsingOTPenabled = val;
    notifyListeners();
  }

  void changeInputOption(context) {
    var index = DefaultTabController.of(context).index;
    if (index == 0) {
      DefaultTabController.of(context).animateTo(1);
    } else {
      DefaultTabController.of(context).animateTo(0);
    }
  }

  void onPasswordObscureChanged() {
    passwordObscured = !passwordObscured;
    notifyListeners();
  }

  String mobileValidator(String val) {
    if (val.length == 0) {
      return "No mobile number provided";
    }
    if (val.length != 10) {
      return "Invalid mobile number";
    }
    return null;
  }

  String passwordValidator(String val) {
    if (_loginUsingOTPenabled) return null;
    if (val.length == 0) {
      return "No password provided";
    }
    return null;
  }

  String otpValidator(String val) {
    if (!_loginUsingOTPenabled) return null;
    if (val.length == 0) {
      return "No OTP provided";
    }
    if (val.length != otpLength) {
      return "Invalid OTP provided";
    }
    return null;
  }

  void registerUser() {
    // _navigationService.pushNamed(Routes.userRegistrationView);
  }

  void forgotPassword() {
    // _navigationService.pushNamed(Routes.forgotPasswordView);
  }

  void generateOTP() async {
    try {
      if (_mobileController.text.length != mobileNumberLength)
        throw ("Invalid mobile number provided");
      setBusy(true);
      if (await _authService.generateOtp(int.parse(_mobileController.text))) {
        startResendCodeTimer();
        _otpGeneratedForNumber = int.parse(_mobileController.text);
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      String message;
      if (e is DioError) {
        message = e.response.data["message"];
      }
      if (e is String) {
        message = e;
      }
      _navigationService.displayDialog(ErrorDialog(
        message: message,
      ));
    }
  }

  void resendOtp() async {
    try {
      if (_mobileController.text.length != mobileNumberLength)
        throw ("Invalid mobile number provided");
      setBusy(true);
      if (await _authService.generateOtp(int.parse(_mobileController.text))) {
        startResendCodeTimer();
        _otpGeneratedForNumber = int.parse(_mobileController.text);
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      String message;
      if (e is DioError) {
        message = e.response.data["message"];
      }
      _navigationService.displayDialog(ErrorDialog(message: message));
    }
  }

  void updateOtp() async {
    // try {
    //   _authService.updateOtp(_otpGeneratedForNumber);
    // } catch (_) {}
  }

  void startResendCodeTimer() {
    _resendCounterValue = _waitingDurationInSeconds;
    stopResendCodeTime();
    _otpTimer = null;
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendCounterValue <= 1) {
        stopResendCodeTime();
        updateOtp();
      } else {
        _resendCounterValue -= 1;
      }
      notifyListeners();
    });
  }

  void stopResendCodeTime() {
    if (_otpTimer?.isActive ?? false) {
      _otpTimer.cancel();
    }
  }

  void login() async {
    try {
      _navigationService.pushNamed(Routes.homePageView);
      return;
      if (!_formKey.currentState.validate()) return;
      bool success = false;
      setBusy(true);
      // if (_loginUsingOTPenabled) {
      //   success = await _authService.loginWithOtp(_mobileController.text.trim(),
      //       int.parse(_otpController.text.trim()));
      // } else {
      //   success = await _authService.loginWithPassword(
      //       _mobileController.text.trim(), _passwordController.text.trim());
      // }
      if (!success) throw Error;
      // await _authService.getUserProfile();
      // _navigationService.pushReplacementNamed(Routes.tabRoute);
      setBusy(false);
    } catch (e) {
      setBusy(false);
      String message;
      if (e is DioError) {
        if (e.error is SocketException) {
          message = "Internet not available";
        } else {
          message = e.response.data["message"];
        }
      }
      _navigationService.displayDialog(ErrorDialog(message: message));
    }
  }

  @override
  void dispose() {
    stopResendCodeTime();
    _otpController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
