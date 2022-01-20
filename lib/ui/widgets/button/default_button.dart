// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const DefaultButton({this.onPressed, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        // style: TextStyles.description1.copyWith(
        //     color: onPressed == null
        //         ? AppColors.unselectedColor
        //         : AppColors.fillColor),
      ),
      style: TextButton.styleFrom(
        // backgroundColor: AppColors.redColor,
        minimumSize: const Size(140, 30),
        shape: const RoundedRectangleBorder(),
      ),
    );
  }
}
