import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final _navigationService = locator<NavigationService>();
  final String message;
  InfoDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      // contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message ?? "An Error Occured, please try again later!",
                // style: TextStyles.description1,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _navigationService.pop,
          child: const Text("Okay"),
        )
      ],
    );
  }
}
