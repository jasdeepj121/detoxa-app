import 'package:auto_size_text/auto_size_text.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/dataModels/eye_tracker_enums.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/color_blindness_test/color_blindness_view_model.dart';

import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

class ColorBlindnessTestView extends StatefulWidget {
  const ColorBlindnessTestView({Key key}) : super(key: key);

  @override
  _ColorBlindnessTestViewState createState() => _ColorBlindnessTestViewState();
}

class _ColorBlindnessTestViewState extends State<ColorBlindnessTestView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<ColorBlindnessTestViewModel>.reactive(
      viewModelBuilder: () => ColorBlindnessTestViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Color Blindness Test"),
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
                          Text("1. "),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Select the options below by seeing the object images which shows up inside the box.",
                              // style: TextStyle(color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("2. "),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Repeat the trials until the test is completed.",
                              // style: TextStyle(color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/images/trackers/eyesight_tracker/color_blindness-${model.imageNumber}.png",
                        width: double.maxFinite,
                        height: 350,
                        cacheHeight: 350,
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
  final Function(ColorBlindnessOption) optionSelected;
  const _GenerateOptions({
    Key key,
    this.optionSelected,
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
          childAspectRatio: 4.3,
          crossAxisSpacing: 16,
          // mainAxisExtent: 50,
          mainAxisSpacing: 16,
        ),
        itemCount: ColorBlindnessOption.values.length,
        itemBuilder: (context, index) {
          return RoundedButton(
            text:
                describeEnum(ColorBlindnessOption.values[index]).toUpperCase(),
            onPressed: () => optionSelected(ColorBlindnessOption.values[index]),
          );
        },
      ),
    );
  }
}
