import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/eyesight_tracker_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
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
      builder: (context, model, child) {
        return Scaffold(
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
