import 'package:detoxa/ui/routes/auth_screens/login/login_view_model.dart';
import 'package:detoxa/ui/widgets/button/default_button.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/button/roundedOutlinedButton.dart';
import 'package:detoxa/ui/widgets/loaders/circularLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  String displayTimeRemaining(int seconds) {
    int min = 0;
    int sec = seconds;
    if (seconds >= 60) {
      min = seconds ~/ 60;
      sec = seconds % 60;
    }
    return "${min.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var primaryColor = Theme.of(context).primaryColor;
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.zero,
    );
    return ViewModelBuilder.reactive(
      builder: (context, LoginViewModel model, _) {
        return Scaffold(
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              // color: AppColors.fillColor,
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.only(
                top: mediaQuery.padding.top,
                // bottom: mediaQuery.padding.bottom,
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: mediaQuery.size.height -
                      mediaQuery.padding.top -
                      mediaQuery.padding.bottom,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Hero(
                            tag: "logo",
                            child: Image.asset(
                              "assets/images/logos/cardio_inter.png",
                              width: mediaQuery.size.width / 2,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 14,
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all()),
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            key: model.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: model.loginUsingOTPenabled
                                                  ? RoundedOutlinedButton(
                                                      onPressed: () => model
                                                          .loginUsingOtp(false),
                                                      text:
                                                          "Login using Password",
                                                    )
                                                  : RoundedButton(
                                                      text:
                                                          "Login using Password",
                                                      onPressed: () {},
                                                    ),
                                            ),
                                            SizedBox(
                                                width:
                                                    mediaQuery.size.width / 50),
                                            Expanded(
                                              flex: 1,
                                              child: !model.loginUsingOTPenabled
                                                  ? RoundedOutlinedButton(
                                                      onPressed: () => model
                                                          .loginUsingOtp(true),
                                                      text: "Login using OTP",
                                                    )
                                                  : RoundedButton(
                                                      text: "Login using OTP",
                                                      onPressed: () {},
                                                    ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          // height: 60,
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextFormField(
                                            controller: model.mobileController,
                                            decoration: InputDecoration(
                                              hintText: "Mobile Number",
                                              border: outlineInputBorder,
                                              counterText: "",
                                              isDense: true,
                                            ),
                                            maxLength: model.mobileNumberLength,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            keyboardType: TextInputType.number,
                                            validator: model.mobileValidator,
                                          ),
                                        ),
                                        Container(
                                          // height: 60,
                                          padding: const EdgeInsets.all(4.0),
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 150),
                                            child: model.loginUsingOTPenabled
                                                ? TextFormField(
                                                    key: ValueKey("otp"),
                                                    controller:
                                                        model.otpController,
                                                    decoration: InputDecoration(
                                                      hintText: "Enter OTP",
                                                      border:
                                                          outlineInputBorder,
                                                      isDense: true,
                                                      counterText: "",
                                                    ),
                                                    maxLength: model.otpLength,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator:
                                                        model.otpValidator,
                                                  )
                                                : TextFormField(
                                                    key: ValueKey("password"),
                                                    controller: model
                                                        .passwordController,
                                                    obscureText:
                                                        model.passwordObscured,
                                                    decoration: InputDecoration(
                                                      hintText: "Password",
                                                      border:
                                                          outlineInputBorder,
                                                      isDense: true,
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          model.passwordObscured
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                        ),
                                                        onPressed: model
                                                            .onPasswordObscureChanged,
                                                      ),
                                                    ),
                                                    validator:
                                                        model.passwordValidator,
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: model.loginUsingOTPenabled
                                              ? TextButton(
                                                  onPressed: model.otpGenerated
                                                      ? model.timerActive
                                                          ? null
                                                          : model.resendOtp
                                                      : model.generateOTP,
                                                  child: Text(
                                                    model.otpGenerated
                                                        ? model.timerActive
                                                            ? "Time left: ${displayTimeRemaining(model.otpTimeRemaining)}"
                                                            : "Resend OTP"
                                                        : "Generate OTP",
                                                  ))
                                              : TextButton(
                                                  onPressed:
                                                      model.forgotPassword,
                                                  child: const Text(
                                                    "Forgot Password?",
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      model.isBusy
                                          ? const SizedBox(
                                              width: 25,
                                              height: 25,
                                              child: CircularLoader(),
                                            )
                                          : DefaultButton(
                                              text: "LOG IN",
                                              onPressed: model.login,
                                            ),
                                      GestureDetector(
                                        onTap: model.registerUser,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Not a User?",
                                              // style: TextStyles.description1
                                              //     .copyWith(
                                              //         color: primaryColor),
                                            ),
                                            Text(
                                              "Click here to Register",
                                              // style: TextStyles.description1
                                              //     .copyWith(
                                              //         color: primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 5, child: SizedBox(height: 0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
