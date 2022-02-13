import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/dataModels/eye_tracker_enums.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/corneal_curvature_test/corneal_curvature_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/dry_eye_test/dry_eye_view_model.dart';

import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

class CornealCurvatureTestView extends StatefulWidget {
  const CornealCurvatureTestView({Key key}) : super(key: key);

  @override
  _CornealCurvatureTestViewState createState() =>
      _CornealCurvatureTestViewState();
}

class _CornealCurvatureTestViewState extends State<CornealCurvatureTestView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<CornealCurvatureTestViewModel>.reactive(
      viewModelBuilder: () => CornealCurvatureTestViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Corneal Curvature Test"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ExpansionTile(
                    title: const Text(
                      "Instructions",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: const EdgeInsets.all(12),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // Text("1. "),
                          // SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Close the eye atleast for 1 minute.",
                              // style: TextStyle(color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 8),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: const [
                      //     Text("2. "),
                      //     SizedBox(width: 4),
                      //     Expanded(
                      //       child: Text(
                      //         "Repeat the trials until the test is completed.",
                      //         // style: TextStyle(color: AppColors.secondary),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text(
                          //   "${model.imageNumber}. ${headingText(model.imageNumber)}",
                          //   textAlign: TextAlign.center,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/trackers/eyesight_tracker/curvature.png",
                              width: double.maxFinite,
                              height: 340,
                              cacheHeight: 340,
                            ),
                          ),
                          // Text(
                          //   (model.selectedImageDetails[model.imageNumber - 1])
                          //       .toUpperCase(),
                          //   textAlign: TextAlign.center,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 16),
                    child: Column(
                      children: [
                        Text("CHOOSE THE EYE"),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(
                              text: "LEFT",
                              onPressed: model.onLeftEyeSelected,
                              suffix: (model.isLeftEyeSelected ?? false)
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : null,
                            ),
                            RoundedButton(
                              text: "RIGHT",
                              onPressed: model.onRightEyeSelected,
                              suffix: !(model.isLeftEyeSelected ?? true)
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Do you see a line in the above image that is darker or sharper ?",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(
                              text: "Yes",
                              onPressed: model.onYesSelected,
                            ),
                            RoundedButton(
                              text: "No",
                              onPressed: model.onNoSelected,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   "Test progress: ${(model.progress * 100).toStringAsFixed(0)}",
                  //   style: const TextStyle(
                  //     color: AppColors.secondary,
                  //   ),
                  // ),
                  const SizedBox(height: 8),
                  RoundedButton(
                      text: "Confirm", onPressed: model.onConfirmPressed),
                  // _GenerateOptions(optionSelected: model.selectAnswer),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GenerateOptions extends StatelessWidget {
  final Function(DryEyeOption) optionSelected;
  const _GenerateOptions({
    Key key,
    this.optionSelected,
  }) : super(key: key);

  String optionText(DryEyeOption option) {
    switch (option) {
      case DryEyeOption.allTimes:
        return "ALL THE TIMES";
      case DryEyeOption.someTimes:
        return "SOMETIMES";
      case DryEyeOption.mostTimes:
        return "MOST OF THE TIMES";
      case DryEyeOption.never:
        return "NEVER";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4.3,
          crossAxisSpacing: 16,
          // mainAxisExtent: 50,
          mainAxisSpacing: 16,
        ),
        itemCount: DryEyeOption.values.length,
        itemBuilder: (context, index) {
          return RoundedButton(
            text: optionText(DryEyeOption.values[index]),
            onPressed: () => optionSelected(DryEyeOption.values[index]),
          );
        },
      ),
    );
  }
}
