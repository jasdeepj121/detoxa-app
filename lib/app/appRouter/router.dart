import 'package:detoxa/ui/routes/auth_screens/login/login_view.dart';
import 'package:detoxa/ui/routes/auth_screens/userRegistration/user_registration_view.dart';
import 'package:detoxa/ui/routes/splashScreen/splash_screen_view.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const splashScreenView = '/';
  static const loginView = '/login';
  static const userRegistratonView = '/user-registration';

  static const all = {splashScreenView, loginView, userRegistratonView};
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
