import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get activeContext => navigatorKey.currentState.context;

  Future<T> push<T extends Object>(Route<T> route) {
    return navigatorKey.currentState.push(route);
  }

  Future<T> pushNamed<T extends Object>(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void pop<T extends Object>([T result]) {
    return navigatorKey.currentState.pop(result);
  }

  Future<T> displayDialog<T>(Widget dialog, {bool barrierDismissible = true}) {
    return showDialog(
      context: navigatorKey.currentState.overlay.context,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }

  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return navigatorKey.currentState.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState.popUntil(predicate);
  }

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
      String newRouteName, bool Function(Route<dynamic>) predicate,
      {Object arguments}) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }
}
