import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  // ignore: use_key_in_widget_constructors
  const RoundedButton({
    @required this.text,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: onPressed == null
            ? ButtonStyle(
                // backgroundColor: MaterialStateProperty.resolveWith<Color>(
                //   (Set<MaterialState> states) {
                //     if (states.contains(MaterialState.pressed)) {
                //       return Theme.of(context).primaryColor;
                //     }
                //     return Colors.white;
                //   },
                // ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide>(const BorderSide(
                    // color: AppColors.lightTextColor,
                    )),
              )
            : ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
        child: Container(
          // alignment: Alignment.center,
          // height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AutoSizeText(
            text,
            maxLines: 2,
            minFontSize: 8,
            // style: TextStyles.description1.copyWith(
            //     // color:
            //     //     onPressed != null ? Colors.white : AppColors.textColor,
            //     ),
            // textAlign: TextAlign.center,
          ),
        ));
  }
}
