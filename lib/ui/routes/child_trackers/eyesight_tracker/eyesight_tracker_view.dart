import 'package:auto_size_text/auto_size_text.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/app/ui_constants/text_styles/app_text_styles.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/eyesight_tracker_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:detoxa/ui/widgets/button/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EyesightTrackerView extends StatefulWidget {
  const EyesightTrackerView({Key key}) : super(key: key);

  @override
  _EyesightTrackerViewState createState() => _EyesightTrackerViewState();
}

class _EyesightTrackerViewState extends State<EyesightTrackerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<EyesightTrackerViewModel>.reactive(
      viewModelBuilder: () => EyesightTrackerViewModel(),
      onModelReady: (model) => model.addImagesToCache(context),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.redAccent[100].withOpacity(0.5),
                  Colors.white,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black87.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        // text: "Track",
                        children: [
                          TextSpan(
                            text: "Track ",
                          ),
                          TextSpan(
                            // style: TextStyle(
                            //   color: AppColors.secondary,
                            // ),
                            text: "Your Child's Eyesight",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  EyesightTestNameCard(
                    assetImage:
                        "assets/images/trackers/eyesight_tracker/color_blindness-1.png",
                    onStartPressed: model.onColorBlindnessPressed,
                    testName: "Color Blindess Test",
                  ),
                  EyesightTestNameCard(
                    assetImage:
                        "assets/images/trackers/eyesight_tracker/Tracker Card2 Image.png",
                    onStartPressed: model.onVisualAcquityPressed,
                    testName: "Visual Acquity Test",
                  ),
                  EyesightTestNameCard(
                    assetImage:
                        "assets/images/trackers/eyesight_tracker/Tracker Card3 Image.png",
                    onStartPressed: model.onAstigmatismPressed,
                    testName: "Astigmatism Test",
                  ),
                  EyesightTestNameCard(
                    assetImage:
                        "assets/images/trackers/eyesight_tracker/Tracker Card4 Image.png",
                    onStartPressed: model.onCornealCurvaturePressed,
                    testName: "Corneal Curvature Test",
                  ),
                  EyesightTestNameCard(
                    assetImage:
                        "assets/images/trackers/eyesight_tracker/Dry Eye Test.png",
                    onStartPressed: model.onDryEyePressed,
                    testName: "Dry Eye Test",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EyesightTestNameCard extends StatelessWidget {
  final String testName;
  final Function onStartPressed;
  final String assetImage;
  const EyesightTestNameCard({
    Key key,
    this.assetImage,
    this.onStartPressed,
    this.testName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 370),
      // height: 100,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primarySwatch,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  testName ?? "",
                  maxLines: 1,
                  minFontSize: 8,
                  style: AppTextStyles.headerTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0).copyWith(bottom: 0),
                child: RoundedButton(
                    text: "Start Test", onPressed: onStartPressed),
              )
            ],
          ),
          Container(
            height: 70,
            width: 70,
            color: (assetImage ?? "").isEmpty ? Colors.grey : null,
            child: (assetImage ?? "").isEmpty
                ? null
                : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      child: Image.asset(
                        assetImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                ),
          ),
        ],
      ),
    );
  }
}
