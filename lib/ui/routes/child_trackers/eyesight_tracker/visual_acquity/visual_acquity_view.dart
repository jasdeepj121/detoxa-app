import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/dataModels/eye_tracker_enums.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/astigmatism/astigmatism_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/corneal_curvature_test/corneal_curvature_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/dry_eye_test/dry_eye_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/visual_acquity/visual_acquity_view_model.dart';

import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

class VisualAcquityTestView extends StatefulWidget {
  const VisualAcquityTestView({Key key}) : super(key: key);

  @override
  _VisualAcquityTestState createState() => _VisualAcquityTestState();
}

class _VisualAcquityTestState extends State<VisualAcquityTestView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<VisualAcquityTestViewModel>.reactive(
      viewModelBuilder: () => VisualAcquityTestViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Visual Acquity Test"),
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
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
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
                                padding: const EdgeInsets.all(32.0),
                                child: Image.asset(
                                  "assets/images/trackers/eyesight_tracker/visual_acquity.png",
                                  width: double.maxFinite,
                                  fit: BoxFit.fitWidth,
                                  // height: 220,
                                  // cacheHeight: 220,
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
                          "FOR PROCEEDING NEXT",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Select Lowest Line number that your child can read correctly.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     RoundedButton(
                        //       text: "Yes",
                        //       onPressed: model.onYesSelected,
                        //     ),
                        //     RoundedButton(
                        //       text: "No",
                        //       onPressed: model.onNoSelected,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // Text(
                  //   "Test progress: ${(model.progress * 100).toStringAsFixed(0)}",
                  //   style: const TextStyle(
                  //     color: AppColors.secondary,
                  //   ),
                  // ),
                  _GenerateOptions(
                    optionSelected: model.lineSelected,
                    indexSelected: model.getSelectedOption(),
                  ),
                  const SizedBox(height: 8),
                  RoundedButton(
                      text: "Confirm", onPressed: model.onConfirmPressed),
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
  final int indexSelected;
  final Function(int) optionSelected;
  const _GenerateOptions({
    Key key,
    this.optionSelected,
    this.indexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5,
          crossAxisSpacing: 12,
          // mainAxisExtent: 50,
          mainAxisSpacing: 12,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return RoundedButton(
            text: "Line ${index + 1}",
            onPressed: () => optionSelected(index + 1),
            suffix: (indexSelected ?? -1) == (index + 1)
                ? const Icon(Icons.check)
                : null,
          );
        },
      ),
    );
  }
}
