import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const AspectRatio(
          aspectRatio: 1, child: CupertinoActivityIndicator());
    } else {
      return Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
        child: const AspectRatio(
          aspectRatio: 1,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
