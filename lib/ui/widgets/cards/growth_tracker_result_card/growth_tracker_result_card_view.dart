import 'package:auto_size_text/auto_size_text.dart';
import 'package:detoxa/app/ui_constants/text_styles/app_text_styles.dart';
import 'package:detoxa/dataModels/child.dart';
import 'package:detoxa/dataModels/gender.dart';
import 'package:detoxa/dataModels/new_growth_tracker.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:detoxa/ui/widgets/cards/growth_tracker_result_card/growth_tracker_result_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

enum SliderType { height, weight, bmi }

class GrowthTrackerResultCardView extends StatelessWidget {
  final NewGrowthTrackerReport newGrowthTracker;

  GrowthTrackerResultCardView({
    this.newGrowthTracker,
    Key key,
  }) : super(key: key);

  final fontGroup = AutoSizeGroup();
  Widget smText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<GrowthTrackerResultCardViewModel>.reactive(
      viewModelBuilder: () => GrowthTrackerResultCardViewModel(),
      onModelReady: (model) => model.setInitialData(newGrowthTracker),
      builder: (context, model, child) {
        return Dialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: SafeArea(
            child: SizedBox(
              // margin: const EdgeInsets.all(8),
              width: double.maxFinite,
              height: size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Child Growth Details",
                              style: AppTextStyles.text2,
                            ),
                            SizedBox(
                              height: 35,
                              width: 35,
                              child: IconButton(
                                icon: const Icon(Icons.cancel),
                                iconSize: 20,
                                onPressed: model.onCancelPressed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 240,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10).copyWith(right: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                      "Name as Entered: "),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                      "Age as Entered: "),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText("Gender: "),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                      newGrowthTracker?.name ??
                                                          ""),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                      "${newGrowthTracker?.age ?? ""} Years"),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                    (newGrowthTracker?.gender ??
                                                                Gender.male) ==
                                                            Gender.male
                                                        ? "Male"
                                                        : "Female",
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: smText(
                                                        "Heights as Entered: ")),
                                              ),
                                              Expanded(
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: smText(
                                                        "Weight as Entered: ")),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText("Exact BMI: "),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                    "${newGrowthTracker.height ?? ""} cm",
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                    "${newGrowthTracker.weight} Kg",
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: smText(
                                                    newGrowthTracker.bmi
                                                            .toStringAsFixed(
                                                                2) ??
                                                        "",
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 8),
                            // AutoSizeText(
                            //   "The Height of the child is the normal range",
                            //   textAlign: TextAlign.center,
                            //   maxLines: 1,
                            //   group: fontGroup,
                            // ),
                            // AutoSizeText(
                            //   "The Optimal height of the child based on the age and gender is 86cm",
                            //   textAlign: TextAlign.center,
                            //   maxLines: 2,
                            //   group: fontGroup,
                            // ),
                            // SizedBox(height: 8),
                            // AutoSizeText(
                            //   "The Weight of the child is the normal range",
                            //   textAlign: TextAlign.center,
                            //   maxLines: 1,
                            //   group: fontGroup,
                            // ),
                            // AutoSizeText(
                            //   "The Optimal weight of the child based on the age and gender is 13Kg",
                            //   textAlign: TextAlign.center,
                            //   maxLines: 2,
                            //   group: fontGroup,
                            // ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.center,
                              child: RoundedButton(
                                text: "Calculate Again",
                                onPressed: model.onCalculatePressed,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 475,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VerticalSlider(
                              sliderType: SliderType.height,
                              percentValue: 24,
                              gender: newGrowthTracker.gender,
                            ),
                            VerticalSlider(
                              sliderType: SliderType.weight,
                              percentValue: 99,
                              gender: newGrowthTracker.gender,
                            ),
                            VerticalSlider(
                              sliderType: SliderType.bmi,
                              percentValue: 24,
                              gender: newGrowthTracker.gender,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TextButton(
                            //   onPressed: model.onSharePressed,
                            //   child: Text("Share"),
                            // ),
                            TextButton(
                              onPressed: model.onDownloadPressed,
                              child: const Text("Download"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class VerticalSlider extends StatelessWidget {
  final SliderType sliderType;
  final double percentValue;
  final Gender gender;

  const VerticalSlider({
    Key key,
    this.sliderType,
    this.percentValue = 1,
    this.gender = Gender.male,
  }) : super(key: key);

  Widget rotatedText(String text) {
    return Expanded(
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double factor = 100 - percentValue;
    return Padding(
      padding: const EdgeInsets.all(3.0).copyWith(right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                rotatedText(
                  sliderType == SliderType.bmi
                      ? "Morbidly obese BMI range"
                      : "More than ideal ${sliderType == SliderType.height ? "height" : "weight"} range",
                ),
                rotatedText(
                  sliderType == SliderType.bmi
                      ? "Obese BMI range"
                      : "Ideal ${sliderType == SliderType.height ? "height" : "weight"} range",
                ),
                rotatedText(
                  sliderType == SliderType.bmi
                      ? "Ideal BMI range"
                      : "Less than ideal ${sliderType == SliderType.height ? "height" : "weight"} range",
                ),
                if (sliderType == SliderType.bmi)
                  rotatedText("Less than ideal BMI range"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 2),
            child: Container(
              width: 20,
              padding: const EdgeInsets.all(2.0),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(),
                // color: Colors.greenAccent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Expanded(
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Expanded(
                      child: Container(
                        color: sliderType == SliderType.bmi
                            ? Colors.blueAccent
                            : Colors.yellow,
                      ),
                    ),
                    if (sliderType == SliderType.bmi) const SizedBox(height: 2),
                    if (sliderType == SliderType.bmi)
                      Expanded(
                        child: Container(
                          color: Colors.yellow,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    "${(sliderType == SliderType.bmi) ? "BMI" : (sliderType == SliderType.height) ? "Height" : "Weight"} Analysis",
                  ),
                ),
                Spacer(
                  flex: percentValue.toInt(),
                ),
                SizedBox(
                    height: 100,
                    width: 50,
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    child: Image.asset(
                      "assets/images/trackers/growth_tracker/happy-${gender == Gender.male ? "boy" : "girl"}.png",
                    )),
                Spacer(
                  flex: factor.toInt(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
