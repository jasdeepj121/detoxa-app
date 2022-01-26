import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/child_trackers/development_tracker/development_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DevelopmentTrackerView extends StatefulWidget {
  const DevelopmentTrackerView({Key key}) : super(key: key);

  @override
  _DevelopmentTrackerViewState createState() => _DevelopmentTrackerViewState();
}

class _DevelopmentTrackerViewState extends State<DevelopmentTrackerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<DevelopmentTrackerViewModel>.reactive(
      viewModelBuilder: () => DevelopmentTrackerViewModel(),
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
