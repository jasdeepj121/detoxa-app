import 'dart:io';

import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/app/ui_constants/strings/error_texts.dart';
import 'package:detoxa/app/ui_constants/text_styles/app_text_styles.dart';
import 'package:detoxa/dataModels/otp.dart';
import 'package:detoxa/dataModels/user.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/loaders/circularLoader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationCard extends StatefulWidget {
  final String mobile;
  final OtpResponse otp;
  final bool verifyForLogin;
  final User user;

  const OtpVerificationCard({
    Key key,
    @required this.mobile,
    @required this.otp,
    this.verifyForLogin = true,
    this.user,
  }) : super(key: key);
  @override
  _OtpVerificationCardState createState() => _OtpVerificationCardState();
}

class _OtpVerificationCardState extends State<OtpVerificationCard> {
  final NavigationService _navigationService = locator<NavigationService>();
  String _otpEntered = "";
  final AuthService _authService = locator<AuthService>();
  bool _isLoading = false;
  String _errorMessage = "";
  bool _hasError = false;

  Future _verifyOtp() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
      if (widget.verifyForLogin) {
        await _authService.loginWithOtp(
          otp: _otpEntered,
          otpResponse: widget.otp,
        );
      } else {
        await _authService.registerUser(
          email: widget.user.email,
          name: widget.user.fullName,
          password: widget.user.password,
          termsAccepted: true,
          otp: _otpEntered,
          otpResponse: widget.otp,
        );
      }
      setState(() {
        _isLoading = false;
      });
      _navigationService.pop(true);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        if (e is DioError) {
          if (e.error is SocketException) {
            _errorMessage = kNoInternet;
          } else if (e.response.data is List) {
            if ((e.response.data as List).isNotEmpty) {
              _errorMessage = e.response.data.first;
            }
          } else if (e.response.data is Map) {
            _errorMessage = "";
            (e.response.data as Map).forEach((key, value) {
              _errorMessage += "$key: $value";
            });
          } else {
            _errorMessage = kErrorOccuredTryLater;
          }
        } else {
          _errorMessage = kErrorOccuredTryLater;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 350, maxWidth: 320),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.secondary,
                  ),
                  iconSize: 32,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Enter Otp sent to your number ",
                textAlign: TextAlign.center,
                style: AppTextStyles.description2,
              ),
              Text(
                widget.mobile,
                textAlign: TextAlign.center,
                style: AppTextStyles.description2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                length: _authService.otpLength,
                appContext: context,
                animationType: AnimationType.scale,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12.0),
                  borderWidth: 1,
                  fieldHeight: 40,
                  fieldWidth: 40,
                  selectedColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                ),
                animationDuration: const Duration(milliseconds: 100),
                backgroundColor: Colors.transparent,
                enableActiveFill: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textStyle: AppTextStyles.description1,
                autoFocus: true,
                onChanged: (text) {
                  setState(() {
                    _otpEntered = text;
                  });
                },
              ),
              const SizedBox(height: 12),
              if (_hasError)
                Text(
                  _errorMessage,
                  maxLines: 2,
                  style: AppTextStyles.errorMessage,
                ),
              const SizedBox(height: 12),
              _isLoading
                  ? const CircularLoader()
                  : RoundedButton(
                      text: "Verify",
                      onPressed: (_otpEntered.length == _authService.otpLength)
                          ? _verifyOtp
                          : null,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
