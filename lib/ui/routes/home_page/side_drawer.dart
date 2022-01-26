import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primarySwatch,
      child: IconButton(
        onPressed: locator<AuthService>().logout,
        icon: Icon(Icons.logout),
      ),
    );
  }
}
