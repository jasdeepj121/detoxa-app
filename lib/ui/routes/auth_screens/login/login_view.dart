import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/auth_screens/login/login_view_model.dart';
import 'package:detoxa/ui/widgets/button/default_button.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/button/roundedOutlinedButton.dart';
import 'package:detoxa/ui/widgets/loaders/circularLoader.dart';
import 'package:detoxa/ui/widgets/textfields/box_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  // String displayTimeRemaining(int seconds) {
  //   int min = 0;
  //   int sec = seconds;
  //   if (seconds >= 60) {
  //     min = seconds ~/ 60;
  //     sec = seconds % 60;
  //   }
  //   return "${min.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")}";
  // }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    // var primaryColor = Theme.of(context).primaryColor;
    // var outlineInputBorder = OutlineInputBorder(
    //   borderSide: BorderSide(color: primaryColor),
    //   borderRadius: BorderRadius.zero,
    // );

    String displayTimeRemaining(int seconds) {
      int min = 0;
      int sec = seconds;
      if (seconds >= 60) {
        min = seconds ~/ 60;
        sec = seconds % 60;
      }
      return "${min.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")}";
    }

    SizedBox _height(double height) {
      return SizedBox(height: height);
    }

    return ViewModelBuilder.reactive(
      builder: (context, LoginViewModel model, _) {
        return Scaffold(
          // backgroundColor: Theme.of(context).primaryColor,
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(width: 5, color: Colors.yellow),
              //   color: Colors.transparent,
              // ),
              width: double.maxFinite,
              height: mediaQuery.size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mediaQuery.padding.top + kToolbarHeight + 24,
                    ),
                    Hero(
                      tag: kAppLogo,
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Let's get started"),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 400,
                      child: DefaultTabController(
                        length: 2,
                        child: Builder(builder: (context) {
                          return Form(
                            key: model.formKey,
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: Column(
                                    children: [
                                      Column(
                                        key: const ValueKey("mobile"),
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Mobile Number"),
                                          ),
                                          _height(4),
                                          BoxTextFormField(
                                            controller: model.mobileController,
                                            validator: model.mobileValidator,
                                            keyboardType: TextInputType.number,
                                            maxLength: 10,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                          _height(16),
                                          // const Align(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Text("Otp"),
                                          // ),
                                          // _height(4),
                                          // BoxTextFormField(
                                          //   controller: model.otpController,
                                          //   validator: model.otpValidator,
                                          //   keyboardType: TextInputType.number,
                                          //   inputFormatters: [
                                          //     FilteringTextInputFormatter
                                          //         .digitsOnly
                                          //   ],
                                          // ),
                                          // Align(
                                          //   alignment: Alignment.centerRight,
                                          //   child: TextButton(
                                          //     onPressed: model.otpGenerated
                                          //         ? model.timerActive
                                          //             ? null
                                          //             : model.resendOtp
                                          //         : model.generateOTP,
                                          //     style: TextButton.styleFrom(
                                          //       // padding:EdgeInsets.zero,
                                          //       // tapTargetSize:
                                          //       // MaterialTapTargetSize.shrinkWrap,
                                          //       visualDensity:
                                          //           VisualDensity.compact,
                                          //     ),
                                          //     child: Text(
                                          //       model.otpGenerated
                                          //           ? model.timerActive
                                          //               ? "Time left: ${displayTimeRemaining(model.otpTimeRemaining)}"
                                          //               : "Resend OTP"
                                          //           : "Generate OTP",
                                          //     ),
                                          //   ),
                                          // ),
                                          // const Text(
                                          //   "Please enter a mobile number to proceed",
                                          // ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            model.changeInputOption(context),
                                        child: Text("Login with credentials?"),
                                        style: TextButton.styleFrom(
                                          // padding:EdgeInsets.zero,
                                          // tapTargetSize:
                                          // MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ),
                                      model.isBusy
                                          ? const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: SizedBox(
                                                width: 28,
                                                height: 28,
                                                child: CircularLoader(),
                                              ),
                                            )
                                          : RoundedButton(
                                              onPressed: model.login,
                                              text: "Send Otp",
                                            ),

                                      TextButton(
                                        onPressed: model.registerUser,
                                        child: Text("Register"),
                                        style: TextButton.styleFrom(
                                            // padding:EdgeInsets.zero,
                                            // tapTargetSize:
                                            //     MaterialTapTargetSize.shrinkWrap,
                                            // visualDensity: VisualDensity.compact,
                                            ),
                                      ),
                                      // model.otpGenerated?
                                      // TextButton(onPressed: mod, child: child)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Enter your Email"),
                                      _height(4),
                                      BoxTextFormField(
                                        controller: model.emailController,
                                        validator: model.emailValidator,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      _height(14),
                                      Text("Enter your Password"),
                                      _height(4),
                                      BoxTextFormField(
                                        controller: model.passwordController,
                                        validator: model.passwordValidator,
                                        obscureText: model.passwordObscured,
                                        suffixIcon: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(48),
                                          child: IconButton(
                                            icon: model.passwordObscured
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off),
                                            onPressed:
                                                model.onPasswordObscureChanged,
                                            visualDensity:
                                                VisualDensity.compact,
                                            padding: const EdgeInsets.all(0),
                                          ),
                                        ),
                                      ),
                                      _height(2),
                                      Center(
                                        child: Column(
                                          children: [
                                            TextButton(
                                              onPressed: () => model
                                                  .changeInputOption(context),
                                              child: Text("Login with mobile?"),
                                            ),
                                            // SizedBox(height: 8),
                                            model.isBusy
                                                ? const Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: SizedBox(
                                                      width: 28,
                                                      height: 28,
                                                      child: CircularLoader(),
                                                    ),
                                                  )
                                                : RoundedButton(
                                                    onPressed: model.login,
                                                    text: "Login",
                                                  ),
                                            TextButton(
                                              onPressed: model.registerUser,
                                              child: Text("Register"),
                                              style: TextButton.styleFrom(
                                                  // padding:EdgeInsets.zero,
                                                  // tapTargetSize:
                                                  //     MaterialTapTargetSize
                                                  //         .shrinkWrap,
                                                  // visualDensity: VisualDensity.compact,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                      // SizedBox(height: 2),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  ],
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
