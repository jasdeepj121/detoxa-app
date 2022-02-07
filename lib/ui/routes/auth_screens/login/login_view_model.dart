import 'dart:async';
import 'dart:io';
import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/otp.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/cards/otpVerifyCard.dart';
import 'package:detoxa/ui/widgets/dialogs/error_dialog.dart';
import 'package:detoxa/utils/email_validator.dart';
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Timer _otpTimer;
  final int _waitingDurationInSeconds = 120;
  int _resendCounterValue;
  String _otpGeneratedForNumber;

  bool passwordObscured = true;
  int mobileNumberLength = 10;
  int otpLength;

  LoginViewModel() {
    // otpLength = _authService.otpLength;
  }

  TextEditingController get mobileController => _mobileController;
  TextEditingController get otpController => _otpController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get emailController => _emailController;

  bool get loginUsingOTPenabled => _loginUsingOTPenabled;
  bool get timerActive => _otpTimer?.isActive ?? false;
  bool get otpGenerated => _otpTimer != null;

  int get otpTimeRemaining => _resendCounterValue;

  GlobalKey<FormState> get formKey => _formKey;

  // void loginUsingOtp(bool val) {
  //   _loginUsingOTPenabled = val;
  //   notifyListeners();
  // }

  void changeInputOption(context) {
    if (isBusy) {
      return;
    }
    var index = DefaultTabController.of(context).index;
    if (index == 0) {
      DefaultTabController.of(context).animateTo(1);
      _loginUsingOTPenabled = false;
    } else {
      DefaultTabController.of(context).animateTo(0);
      _loginUsingOTPenabled = true;
    }
  }

  void onPasswordObscureChanged() {
    passwordObscured = !passwordObscured;
    notifyListeners();
  }

  String mobileValidator(String val) {
    if ((val ?? "").isEmpty) {
      return "Mobile number cannot be left blank";
    }
    if (val.length != 10) {
      return "Invalid mobile number";
    }
    return null;
  }

  String emailValidator(String val) {
    if ((val ?? "").isEmpty) {
      return "Email cannot be left blank";
    }
    if (!(EmailValidator.validate(val))) {
      return "Invalid email";
    }
    return null;
  }

  String passwordValidator(String val) {
    if (_loginUsingOTPenabled) return null;
    if ((val ?? "").isEmpty) {
      return "Password cannot be left blank";
    }
    return null;
  }

  String otpValidator(String val) {
    if (!_loginUsingOTPenabled) return null;
    if (_otpGeneratedForNumber == null) return null;
    if (_otpGeneratedForNumber == mobileController.text.trim()) return null;
    if ((val ?? "").isEmpty) {
      return "No OTP provided";
    }
    // if (val.length != otpLength) {
    //   return "Invalid OTP provided";
    // }
    return null;
  }

  void registerUser() {
    if (isBusy) {
      return;
    }
    _navigationService.pushNamed(Routes.userRegistratonView);
  }

  // void forgotPassword() {
  // _navigationService.pushNamed(Routes.forgotPasswordView);
  // }

  void generateOTP() async {
    try {
      if (isBusy) {
        return;
      }
      if (!_formKey.currentState.validate()) return;
      setBusy(true);
      var otp = await _authService.generateOtp(_mobileController.text);
      if (otp != null) {
        startResendCodeTimer();
        _otpGeneratedForNumber = _mobileController.text.trim();
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      String message;
      if (e is DioError) {
        if (e.response.data is Map) {
          Map resp = e.response.data;
          message = (resp.entries.first.value as List).first.toString();
        }
      }
      if (e is String) {
        message = e.toString();
      }
      _navigationService.displayDialog(ErrorDialog(
        message: message,
      ));
    }
  }

  void resendOtp() async {
    try {
      setBusy(true);
      var otp = await _authService.generateOtp(_mobileController.text);
      if (otp != null) {
        startResendCodeTimer();
        _otpGeneratedForNumber = _mobileController.text;
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

  void startResendCodeTimer() {
    _resendCounterValue = _waitingDurationInSeconds;
    stopResendCodeTime();
    _otpTimer = null;
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendCounterValue <= 1) {
        stopResendCodeTime();
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
      if (!_formKey.currentState.validate()) return;
      bool success = false;
      setBusy(true);
      if (_loginUsingOTPenabled) {
        OtpResponse otp = await _authService.generateOtp(
          _mobileController.text.trim(),
        );
        success = await _navigationService.displayDialog(
          OtpVerificationCard(
            mobile: _mobileController.text.trim(),
            otp: otp,
          ),
          barrierDismissible: false,
        );
        if (success == null) {
          setBusy(false);
          return;
        }
      } else {
        success = await _authService.loginWithPassword(
            _emailController.text.trim(), _passwordController.text.trim());
      }
      if (!success) throw Error;
      // await _authService.getUserProfile();
      _navigationService.pushReplacementNamed(Routes.homePageView);
      setBusy(false);
    } catch (e) {
      setBusy(false);
      String message;
      if (e is DioError) {
        if (e.error is SocketException) {
          message = "Internet not available";
        } else if (e.response.data is List) {
          if ((e.response.data as List).isNotEmpty) {
            message = e.response.data[0];
          }
        }
      }
      _navigationService.displayDialog(ErrorDialog(message: message));
    }
  }

  @override
  void dispose() {
    stopResendCodeTime();
    _otpController?.dispose();
    _mobileController?.dispose();
    _passwordController?.dispose();
    _emailController?.dispose();
    super.dispose();
  }
}
