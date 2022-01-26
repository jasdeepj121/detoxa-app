import 'dart:io';

import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/app/ui_constants/text_styles/app_text_styles.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationCard extends StatefulWidget {
  final String mobile;

  const OtpVerificationCard({
    Key key,
    @required this.mobile,
  }) : super(key: key);
  @override
  _OtpVerificationCardState createState() => _OtpVerificationCardState();
}

class _OtpVerificationCardState extends State<OtpVerificationCard> {
  final NavigationService _navigationService = locator<NavigationService>();
  final int _otpLength = 5;
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
      // User response = await _authService.verifyOtpForAnotherPatient(
      //     widget.mobile, widget.countryCode, _otpEntered);
      // if (response != null) {
      //   if (response is User) _navigationService.pop(response);
      // }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        if (e is DioError) {
          if (e.error is SocketException) {
            _errorMessage = "INTERNET_NOT_AVAILABLEe";
          }
          // _errorMessage = e.response.data["msg"] ?? "";
          _errorMessage = "An error occured, please try again later.";
        } else {
          _errorMessage = "ERROR_TRY_AGAIN_LATER";
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
                length: _otpLength,
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
              RoundedButton(
                text: "Verify",
                onPressed: (_otpEntered.length == _otpLength && (!_isLoading))
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
