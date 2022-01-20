import 'package:detoxa/ui/routes/splashScreen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
