import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/vaccination_tracker/vaccination_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VaccinationTrackerView extends StatefulWidget {
  const VaccinationTrackerView({Key key}) : super(key: key);

  @override
  _VaccinationTrackerViewState createState() => _VaccinationTrackerViewState();
}

class _VaccinationTrackerViewState extends State<VaccinationTrackerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<VaccinationTrackerViewModel>.reactive(
      viewModelBuilder: () => VaccinationTrackerViewModel(),
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
