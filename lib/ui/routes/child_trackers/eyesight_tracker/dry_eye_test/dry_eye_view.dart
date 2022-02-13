import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/dataModels/eye_tracker_enums.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/dry_eye_test/dry_eye_view_model.dart';

import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

class DryEyeTestView extends StatefulWidget {
  const DryEyeTestView({Key key}) : super(key: key);

  @override
  _ColorBlindnessTestViewState createState() => _ColorBlindnessTestViewState();
}

class _ColorBlindnessTestViewState extends State<DryEyeTestView> {
  String headingText(int imageNumber) {
    if (imageNumber < 6) {
      return "Have you experienced any of the following over the last week?";
    } else if (imageNumber < 10) {
      return "Have problems with your eyes limited you when performing any of the following tasks over the last week?";
    }
    return "Have your eyes felt uncomfortable in any of the following situations over the last week?";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<DryEyeTestViewModel>.reactive(
      viewModelBuilder: () => DryEyeTestViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dry Eye Test"),
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
                          Text(
                            "${model.imageNumber}. ${headingText(model.imageNumber)}",
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/images/trackers/eyesight_tracker/dry_eye_${model.imageNumber}.png",
                              width: double.maxFinite,
                              height: 220,
                              cacheHeight: 220,
                            ),
                          ),
                          Text(
                            (model.selectedImageDetails[model.imageNumber - 1])
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 16),
                    child: LinearPercentIndicator(
                      animateFromLastPercent: true,
                      percent: model.progress,
                    ),
                  ),
                  Text(
                    "Test progress: ${(model.progress * 100).toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _GenerateOptions(optionSelected: model.selectAnswer),
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
