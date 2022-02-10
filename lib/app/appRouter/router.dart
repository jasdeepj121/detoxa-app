import 'package:detoxa/ui/routes/auth_screens/login/login_view.dart';
import 'package:detoxa/ui/routes/auth_screens/userRegistration/user_registration_view.dart';
import 'package:detoxa/ui/routes/child_trackers/development_tracker/development_tracker_view.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/color_blindness_test.dart/color_blindness_view.dart';
import 'package:detoxa/ui/routes/child_trackers/eyesight_tracker/eyesight_tracker_view.dart';
import 'package:detoxa/ui/routes/child_trackers/food_tracker/food_tracker_view.dart';
import 'package:detoxa/ui/routes/child_trackers/growth_tracker/growth_tracker_view.dart';
import 'package:detoxa/ui/routes/child_trackers/hand_eye_tracker/hand_eye_tracker_view.dart';
import 'package:detoxa/ui/routes/child_trackers/vaccination_tracker/vaccination_tracker_view.dart';
import 'package:detoxa/ui/routes/home_page/home_page_view.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const splashScreenView = '/';
  static const loginView = '/login';
  static const userRegistratonView = '/user-registration';
  static const homePageView = '/home';
  static const growthTrackerView = '/growth-tracker';
  static const developmentTrackerView = '/development-tracker';
  static const vaccinationTrackerView = '/vaccination-tracker';
  static const handEyeTrackerView = '/hand-eye-tracker';
  static const foodTrackerView = '/food-tracker';
  static const eyesightTrackerView = '/eyesight-tracker';
  static const colorBlindnessTestView = '/color-blindness-test';
  static const visualAcquityTestView = '/visual-acquity-test';
  static const astigmatismTestView = '/astigmatism-test';
  static const cornealCurvatureTestView = '/corneal-curvature-test';
  static const dryEyeTestView = '/dry-eye-test';

  // static const eyesightTrackerView = '/eyesight-tracker';
  // static const eyesightTrackerView = '/eyesight-tracker';
  // static const eyesightTrackerView = '/eyesight-tracker';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreenView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const SplashScreenView(),
          settings: settings,
        );
      case Routes.loginView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case Routes.userRegistratonView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const UserRegistrationView(),
          settings: settings,
        );
      case Routes.homePageView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const HomePageView(),
          settings: settings,
        );
      case Routes.growthTrackerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const GrowthTrackerView(),
          settings: settings,
        );
      case Routes.developmentTrackerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const DevelopmentTrackerView(),
          settings: settings,
        );
      case Routes.eyesightTrackerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const EyesightTrackerView(),
          settings: settings,
        );
      case Routes.colorBlindnessTestView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const ColorBlindnessTestView(),
          settings: settings,
        );
      //   case Routes.visualAcquityTestView:
      // return MaterialPageRoute<dynamic>(
      //   builder: (context) => const (),
      //   settings: settings,
      // );
      //   case Routes.astigmatismTestView:
      // return MaterialPageRoute<dynamic>(
      //   builder: (context) => const (),
      //   settings: settings,
      // );
      //   case Routes.cornealCurvatureTestView:
      // return MaterialPageRoute<dynamic>(
      //   builder: (context) => const (),
      //   settings: settings,
      // );
      //   case Routes.dryEyeTestView:
      // return MaterialPageRoute<dynamic>(
      //   builder: (context) => const (),
      //   settings: settings,
      // );

      case Routes.handEyeTrackerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const HandEyeTrackerView(),
          settings: settings,
        );
      case Routes.vaccinationTrackerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const VaccinationTrackerView(),
          settings: settings,
        );
      case Routes.foodTrackerView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const FoodTrackerView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("${settings.name} route does not exist"),
            ),
          ),
        );
    }
  }
}
