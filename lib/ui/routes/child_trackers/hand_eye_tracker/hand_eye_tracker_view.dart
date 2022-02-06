import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/hand_eye_tracker/hand_eye_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HandEyeTrackerView extends StatefulWidget {
  const HandEyeTrackerView({Key key}) : super(key: key);

  @override
  _HandEyeTrackerViewState createState() => _HandEyeTrackerViewState();
}

class _HandEyeTrackerViewState extends State<HandEyeTrackerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<HandEyeTrackerViewModel>.reactive(
      viewModelBuilder: () => HandEyeTrackerViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
            body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Hero(
              tag: kAppLogo,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ),
          ),
        ));
      },
    );
  }
}
