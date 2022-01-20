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
    return ViewModelBuilder.reactive(
      builder: (context, LoginViewModel model, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                width: double.maxFinite,
                height: mediaQuery.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: kAppLogo,
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 1),
                    SizedBox(
                      height: 270,
                      child: DefaultTabController(
                        length: 2,
                        child: Builder(builder: (context) {
                          return Form(
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: Column(
                                    children: [
                                      Text("Lets get started"),
                                      SizedBox(height: 16),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Mobile Number*"),
                                      ),
                                      SizedBox(height: 6),
                                      BoxTextFormField(),
                                      SizedBox(height: 16),
                                      Text("Please enter a number to proceed"),
                                      SizedBox(height: 2),
                                      TextButton(
                                        onPressed: () =>
                                            model.changeInputOption(context),
                                        child: Text("Login with credentials?"),
                                      ),
                                      SizedBox(height: 2),
                                      RoundedButton(
                                        onPressed: model.login,
                                        text: "Proceed to login",
                                      )
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
                                      const Center(
                                          child:
                                              Text("Login with credentials")),
                                      SizedBox(height: 14),
                                      Text("Enter your Email*"),
                                      SizedBox(height: 4),
                                      BoxTextFormField(),
                                      SizedBox(height: 14),
                                      Text("Enter your Password*"),
                                      SizedBox(height: 4),
                                      BoxTextFormField(),
                                      SizedBox(height: 2),
                                      Center(
                                        child: TextButton(
                                          onPressed: () =>
                                              model.changeInputOption(context),
                                          child: Text("Login with mobile?"),
                                        ),
                                      ),
                                      // SizedBox(height: 8),
                                      Center(
                                        child: RoundedButton(
                                          onPressed: model.login,
                                          text: "Login",
                                        ),
                                      ),
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
