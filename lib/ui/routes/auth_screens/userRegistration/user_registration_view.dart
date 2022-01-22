import 'package:detoxa/ui/routes/auth_screens/userRegistration/user_registration_view_model.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/loaders/circularLoader.dart';
import 'package:detoxa/ui/widgets/textfields/box_form_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({Key key}) : super(key: key);

  @override
  _UserRegistrationViewState createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  final int maxLength = 50;
  final double textfieldPadding = 11;
  final double dropDownPadding = 9;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.zero,
    );
    return ViewModelBuilder<UserRegistrationViewModel>.reactive(
      builder: (context, UserRegistrationViewModel model, _) {
        return Scaffold(
          // backgroundColor: AppColors.primarySwatch,
          body: Container(
            height: mediaQuery.size.height,
            width: double.maxFinite,
            // color: AppColors.fillColor,
            margin: EdgeInsets.only(
              top: mediaQuery.padding.top,
              bottom: mediaQuery.padding.bottom,
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BackButton(),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.blueAccent,
                    ),
                    // SizedBox(
                    //   width: mediaQuery.size.width,
                    //   child: Stack(
                    //     alignment: Alignment.center,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.all(16.0).copyWith(
                    //             left: mediaQuery.size.width / (2.2 * 6.8)),
                    //         child: Hero(
                    //           tag: "logo",
                    //           child: Image.asset(
                    //             "assets/images/logos/cardio_inter.png",
                    //             alignment: Alignment.center,
                    //             width: mediaQuery.size.width / 2.2,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(top: 10, left: 10, child: BackButton()),
                    //     ],
                    //   ),
                    // ),
                    // Text(
                    //   "Fill Your Registration Form",
                    //   textAlign: TextAlign.center,
                    //   // style:
                    //   //     TextStyles.description1.copyWith(color: primaryColor),
                    // ),
                    SizedBox(height: 42),
                    Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      width: mediaQuery.size.width / 1.2,
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            BoxTextFormField(
                              controller: model.nameController,
                              maxLength: maxLength,
                              keyboardType: TextInputType.name,
                              validator: model.nameValidator,
                              hintText: "Full name",
                            ),
                            SizedBox(height: 14),
                            BoxTextFormField(
                              controller: model.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: model.emailValidator,
                              hintText: "Email",
                            ),
                            SizedBox(height: 14),
                            BoxTextFormField(
                              controller: model.mobileController,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: model.mobileValidator,
                              hintText: "Mobile number",
                            ),
                            SizedBox(height: 14),
                            BoxTextFormField(
                              controller: model.passwordController,
                              validator: model.passwordValidator,
                              hintText: "Password",
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: model.termsAgreed,
                                  onChanged: model.onTermAgreedChanged,
                                ),
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'I have read and agree to the ',
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Privacy policy',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap =
                                                  model.onPrivacyPolicyPressed,
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline)),
                                        // TextSpan(text: ' and'),
                                        // TextSpan(
                                        //     text: ' Privacy Policy',
                                        //     recognizer: TapGestureRecognizer()
                                        //       ..onTap =
                                        //           model.onPrivacyPolicyPressed,
                                        //     style: TextStyle(
                                        //         decoration:
                                        //             TextDecoration.underline)),
                                        // TextSpan(
                                        //     text:
                                        //         ' of Cardio Intervention+ resources.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        SizedBox(height: 12),
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
                                text: "Next",
                                onPressed:
                                    !model.termsAgreed ? null : model.onSubmit,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => UserRegistrationViewModel(),
    );
  }
}
