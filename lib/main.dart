import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/app/ui_constants/theme/app_theme.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart' hide Router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const DetoxaApp());
}

class DetoxaApp extends StatelessWidget {
  const DetoxaApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detoxa',
      theme: AppTheme().themeData,
      // debugShowCheckedModeBanner: ,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: Routes.splashScreenView,
      onGenerateRoute: Router().onGenerateRoute,
    );
  }
}
