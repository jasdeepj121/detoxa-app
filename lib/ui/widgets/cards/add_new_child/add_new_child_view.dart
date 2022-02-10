import 'dart:io';

import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/app/ui_constants/text_styles/app_text_styles.dart';
import 'package:detoxa/dataModels/gender.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/dialogs/error_dialog.dart';
import 'package:detoxa/ui/widgets/dialogs/info_dialog.dart';
import 'package:detoxa/ui/widgets/loaders/circularLoader.dart';
import 'package:detoxa/ui/widgets/profile_image.dart';
import 'package:detoxa/ui/widgets/textfields/box_form_text_field.dart';
import 'package:detoxa/ui/widgets/textfields/rounded_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNewChildCard extends StatefulWidget {
  const AddNewChildCard({Key key}) : super(key: key);

  @override
  _AddNewChildCardState createState() => _AddNewChildCardState();
}

class _AddNewChildCardState extends State<AddNewChildCard> {
  DateTime _selectedDate;
  Gender _selectedGender = Gender.male;
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _ageController = TextEditingController();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  File _selectedImageFile;
  File _selectedCroppedImageFile;
  bool _isLoading = false;
  bool _refreshReqOnPrevScreen = false;

  Future displayDatePicker() async {
    var currentDate = DateTime.now();
    var date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? currentDate,
      firstDate: currentDate.subtract(const Duration(days: 18 * 365)),
      lastDate: currentDate,
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void selectImage() async {
    try {
      var imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        File croppedFile = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          compressQuality: 40,
          androidUiSettings: const AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: false,
          ),
        );
        if (croppedFile != null) {
          setState(() {
            _selectedCroppedImageFile = croppedFile;
            _selectedImageFile = File.fromUri(Uri.file(imageFile.path));
          });
        }
      }
    } catch (e) {
      if (e.code == "photo_access_denied") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Permission to access image gallery was denied"),
          ),
        );
      }
    }
  }

  String get getDate {
    if (_selectedDate != null) {
      return DateFormat("dd/MM/yyyy").format(_selectedDate);
    }
    return "dd/mm/yyyy";
  }

  String get getProfileFileName {
    if (_selectedCroppedImageFile == null) {
      return "No file chosen";
    }
    return _selectedImageFile.path.split(Platform.pathSeparator).last;
  }

  void addChild() async {
    try {
      setState(() {
        _isLoading = true;
      });
      int age = (DateTime.now().difference(_selectedDate).inDays) ~/ 365;
      await _authService.createChild(
        age: age.toString(),
        dob: _selectedDate,
        gender: _selectedGender,
        name: _nameController.text.trim(),
        imageFilePath: _selectedCroppedImageFile.path,
      );
      _refreshReqOnPrevScreen = true;
      _navigationService.displayDialog(
        InfoDialog(
          message: "${_nameController.text.trim()} successfully added",
        ),
      );
      _selectedCroppedImageFile = null;
      _selectedImageFile = null;
      _nameController.clear();
      _selectedDate = null;
      _authService.getChildList();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      String errorMessage = "";
      if (e is DioError) {
        errorMessage = e.response.toString();
      }
      setState(() {
        _isLoading = false;
      });

      _navigationService.displayDialog(ErrorDialog(message: errorMessage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add new child details",
                      style: AppTextStyles.text2,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: AppColors.secondary,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pop(_refreshReqOnPrevScreen),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ProfileImage(
                      imageFile: _selectedImageFile,
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: selectImage,
                      child: const Text("Profile Image"),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          getProfileFileName,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 4,
                          child: Text(
                            "Full name:  ",
                          )),
                      Expanded(
                        flex: 7,
                        child: BoxTextFormField(
                          hintText: "Full name",
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       const Expanded(
                //           flex: 4,
                //           child: Text(
                //             "Age:  ",
                //           )),
                //       Expanded(
                //         flex: 7,
                //         child: BoxTextFormField(
                //           hintText: "Age",
                //           // suffixIcon: suffixIcon,
                //           keyboardType: TextInputType.number,
                //           inputFormatters: [
                //             FilteringTextInputFormatter.digitsOnly,
                //             LengthLimitingTextInputFormatter(2),
                //           ],
                //           controller: _ageController,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(flex: 4, child: Text("Gender:  ")),
                      Expanded(
                        flex: 7,
                        child: RoundedDropDown<Gender>(
                          items: Gender.values,
                          onChanged: (newGender) {
                            setState(() {
                              _selectedGender = newGender;
                            });
                          },
                          selectedValue: _selectedGender,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 4,
                          child: Text(
                            "Date of Birth:  ",
                          )),
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                          onTap: displayDatePicker,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getDate,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: IconButton(
                                      onPressed: displayDatePicker,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(
                                        Icons.calendar_today,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(9.0),
                        child: CircularLoader(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedButton(
                            text: "Cancel",
                            onPressed: () => Navigator.of(context)
                                .pop(_refreshReqOnPrevScreen),
                          ),
                          RoundedButton(
                              text: "Add",
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                addChild();
                              }),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
