import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  // final bool usePrimaryColor;
  // ignore: use_key_in_widget_constructors
  const RoundedOutlinedButton({
    @required this.onPressed,
    @required this.text,
    // this.usePrimaryColor = false,
  });

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = Theme.of(context).primaryColor;
    return OutlinedButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: AutoSizeText(
          text,
          // style: TextStyles.description1,
          maxLines: 2,
          minFontSize: 8,
          textAlign: TextAlign.center,
        ),
      ),
      style: OutlinedButton.styleFrom(
        // backgroundColor: Colors.white,
        side: BorderSide(color: _primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
