import 'package:detoxa/ui/routes/auth_screens/userRegistration/user_registration_view_model.dart';
import 'package:detoxa/ui/widgets/button/default_button.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mediaQuery.size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0).copyWith(
                              left: mediaQuery.size.width / (2.2 * 6.8)),
                          child: Hero(
                            tag: "logo",
                            child: Image.asset(
                              "assets/images/logos/cardio_inter.png",
                              alignment: Alignment.center,
                              width: mediaQuery.size.width / 2.2,
                            ),
                          ),
                        ),
                        Positioned(top: 10, left: 10, child: BackButton()),
                      ],
                    ),
                  ),
                  Text(
                    "Fill Your Registration Form",
                    textAlign: TextAlign.center,
                    // style:
                    //     TextStyles.description1.copyWith(color: primaryColor),
                  ),
                  model.isBusy
                      ? Container(
                          height: mediaQuery.size.height / 1.5,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          constraints: BoxConstraints(maxWidth: 500),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          width: mediaQuery.size.width / 1.2,
                          child: Form(
                            key: model.formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: model.nameController,
                                  maxLength: maxLength,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Full Name",
                                    isDense: true,
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: model.nameValidator,
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: model.qualificationController,
                                  maxLength: maxLength,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Qualification",
                                    isDense: true,
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  validator: model.qualificationValidator,
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: model.emailController,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Email Address",
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: model.emailValidator,
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: model.mobileController,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Mobile Number",
                                    isDense: true,
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: model.mobileValidator,
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: model.passcodeController,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Passcode",
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  validator: model.passcodeValidator,
                                ),
                                // SizedBox(height: 8),
                                // DropdownButtonFormField<Country>(
                                //   isExpanded: true,
                                //   hint: Text("Country"),
                                //   decoration: InputDecoration(
                                //     border: outlineInputBorder,
                                //     isDense: true,
                                //     contentPadding:
                                //         EdgeInsets.all(textfieldPadding)
                                //             .copyWith(
                                //                 top: dropDownPadding,
                                //                 bottom: dropDownPadding),
                                //   ),
                                //   items: model.countries
                                //       .map(
                                //         (e) => DropdownMenuItem<Country>(
                                //           child: Text(e.name),
                                //           value: e,
                                //         ),
                                //       )
                                //       .toList(),
                                //   value: model.selectedCountry,
                                //   onChanged: model.onCountryChanged,
                                //   validator: model.countryValidator,
                                // ),
                                // if (model.enableOtherCountries)
                                //   SizedBox(height: 8),
                                // if (model.enableOtherCountries)
                                //   TextFormField(
                                //     key: ValueKey(model.otherCountryController),
                                //     controller: model.otherCountryController,
                                //     decoration: InputDecoration(
                                //       border: outlineInputBorder,
                                //       hintText: "Other Country",
                                //       isDense: true,
                                //       contentPadding:
                                //           EdgeInsets.all(textfieldPadding),
                                //     ),
                                //     validator: model.otherCountryValidator,
                                //   ),
                                // if (!model.enableOtherCountries &&
                                //     model.selectedCountry != null)
                                //   SizedBox(height: 8),
                                // if (!model.enableOtherCountries &&
                                //     model.selectedCountry != null)
                                //   DropdownButtonFormField<String>(
                                //     isExpanded: true,
                                //     hint: Text("State"),
                                //     decoration: InputDecoration(
                                //       border: outlineInputBorder,
                                //       isDense: true,
                                //       contentPadding:
                                //           EdgeInsets.all(textfieldPadding)
                                //               .copyWith(
                                //                   top: dropDownPadding,
                                //                   bottom: dropDownPadding),
                                //     ),
                                //     items: model.states
                                //         .map(
                                //           (e) => DropdownMenuItem<String>(
                                //             child: Text(e),
                                //             value: e,
                                //           ),
                                //         )
                                //         .toList(),
                                //     value: model.selectedState,
                                //     onChanged: model.onStateChanged,
                                //     validator: model.stateValidator,
                                //   ),
                                // if (!model.enableOtherCountries &&
                                //     model.selectedState != null)
                                //   SizedBox(height: 8),
                                // if (!model.enableOtherCountries &&
                                //     model.selectedState != null)
                                //   DropdownButtonFormField<String>(
                                //     isExpanded: true,
                                //     hint: Text("City"),
                                //     decoration: InputDecoration(
                                //       border: outlineInputBorder,
                                //       isDense: true,
                                //       contentPadding:
                                //           EdgeInsets.all(textfieldPadding)
                                //               .copyWith(
                                //                   top: dropDownPadding,
                                //                   bottom: dropDownPadding),
                                //     ),
                                //     items: model.cities
                                //         .map(
                                //           (e) => DropdownMenuItem<String>(
                                //             child: Text(e.trim()),
                                //             value: e,
                                //           ),
                                //         )
                                //         .toList(),
                                //     value: model.selectedCity,
                                //     onChanged: model.onCityChanged,
                                //     validator: model.cityValidator,
                                //   ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: model.hospitalController,
                                  maxLength: maxLength,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Hospital",
                                    isDense: true,
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  // validator: model.hospitalValidator,
                                ),
                                SizedBox(height: 8),
                                // TextFormField(
                                //   controller: model.yearsController,
                                //   decoration: InputDecoration(
                                //     border: outlineInputBorder,
                                //     hintText: "Years in Practice",
                                //     isDense: true,
                                //     contentPadding:
                                //         EdgeInsets.all(textfieldPadding),
                                //   ),
                                //   keyboardType: TextInputType.number,
                                //   inputFormatters: [
                                //     FilteringTextInputFormatter.digitsOnly,
                                //   ],
                                //   validator: model.yearsValidator,
                                // ),
                                // DropdownButtonFormField<YearsInPractice>(
                                //   isExpanded: true,
                                //   hint: Text("Years in Practice"),
                                //   decoration: InputDecoration(
                                //     border: outlineInputBorder,
                                //     isDense: true,
                                //     contentPadding:
                                //         EdgeInsets.all(textfieldPadding)
                                //             .copyWith(
                                //                 top: dropDownPadding,
                                //                 bottom: dropDownPadding),
                                //   ),
                                //   items: model.yearsInPractice
                                //       .map(
                                //         (e) =>
                                //             DropdownMenuItem<YearsInPractice>(
                                //           child: Text(e.name),
                                //           value: e,
                                //         ),
                                //       )
                                //       .toList(),
                                //   value: model.selectedYearsInPractice,
                                //   onChanged: model.onYearsInPracticeChanged,
                                //   validator: model.yearsInPracticeValidator,
                                // ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: model.mciRegController,
                                  maxLength: maxLength,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "MCI Registration Number",
                                    isDense: true,
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  // validator: model.mciRegistrationValidator,
                                ),
                                SizedBox(height: 8),
                                // DropdownButtonFormField<PracticeArea>(
                                //   isExpanded: true,
                                //   hint: Text("Practice Area"),
                                //   decoration: InputDecoration(
                                //     border: outlineInputBorder,
                                //     isDense: true,
                                //     contentPadding:
                                //         EdgeInsets.all(textfieldPadding)
                                //             .copyWith(
                                //                 top: dropDownPadding,
                                //                 bottom: dropDownPadding),
                                //   ),
                                //   items: model.practiceArea
                                //       .map(
                                //         (e) => DropdownMenuItem<PracticeArea>(
                                //           child: Text(e.name),
                                //           value: e,
                                //         ),
                                //       )
                                //       .toList(),
                                //   value: model.selectedPracticeArea,
                                //   onChanged: model.onPracticeAreaChanged,
                                //   validator: model.practiceAreaValidator,
                                // ),
                                // if (model.enableOtherPraticeAreas)
                                //   SizedBox(height: 8),
                                // if (model.enableOtherPraticeAreas)
                                //   TextFormField(
                                //     key: ValueKey(
                                //         model.otherPracticeAreaController),
                                //     controller:
                                //         model.otherPracticeAreaController,
                                //     decoration: InputDecoration(
                                //       border: outlineInputBorder,
                                //       hintText: "Other Practice Area",
                                //       isDense: true,
                                //       contentPadding:
                                //           EdgeInsets.all(textfieldPadding),
                                //     ),
                                //     validator: model.otherPracticeAreaValidator,
                                //   ),
                                SizedBox(height: 8),
                                TextFormField(
                                  key: ValueKey(model.proceduresController),
                                  controller: model.proceduresController,
                                  decoration: InputDecoration(
                                    border: outlineInputBorder,
                                    hintText: "Procedures Undertaken (No.)",
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.all(textfieldPadding),
                                  ),
                                  validator: model.proceduresValidator,
                                ),
                                SizedBox(height: 12),
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
                                                text: 'Terms of Use',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = model
                                                          .onTermsOfUsePressed,
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline)),
                                            TextSpan(text: ' and'),
                                            TextSpan(
                                                text: ' Privacy Policy',
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = model
                                                      .onPrivacyPolicyPressed,
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline)),
                                            TextSpan(
                                                text:
                                                    ' of Cardio Intervention+ resources.'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: Text(
                                    //     "I have read and agree to the Terms of Use and Privacy Policy of Cardio Intervention+ resources.",
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  if (!model.isBusy)
                    Column(
                      children: [
                        SizedBox(height: 12),
                        DefaultButton(
                          text: "Next",
                          onPressed: !model.termsAgreed ? null : model.onSubmit,
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: model.existingUserPressed,
                          child: Text(
                            "Existing User - Click here",
                            // style: TextStyles.description1
                            //     .copyWith(color: primaryColor),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
      onModelReady: (model) => model.fetchFormData(),
      viewModelBuilder: () => UserRegistrationViewModel(),
    );
  }
}
