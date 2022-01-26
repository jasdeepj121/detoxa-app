import 'package:detoxa/app/ui_constants/strings/texts.dart';
import 'package:detoxa/ui/routes/child_trackers/food_tracker/food_tracker_view_model.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view_model.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FoodTrackerView extends StatefulWidget {
  const FoodTrackerView({Key key}) : super(key: key);

  @override
  _FoodTrackerViewState createState() => _FoodTrackerViewState();
}

class _FoodTrackerViewState extends State<FoodTrackerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<FoodTrackerViewModel>.reactive(
      viewModelBuilder: () => FoodTrackerViewModel(),
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
