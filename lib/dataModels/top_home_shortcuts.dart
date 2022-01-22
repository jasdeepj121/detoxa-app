import 'package:flutter/material.dart';

class HomeTopMainShortcuts {
  String assetName;
  String text;
  Color color;
  List<HomeTopSubShortcuts> subShortcuts;

  HomeTopMainShortcuts({
    this.assetName,
    this.color,
    this.subShortcuts,
    this.text,
  });
}

class HomeTopSubShortcuts {
  String assetName;
  String text;
  Color color;
  String link;

  HomeTopSubShortcuts({
    this.assetName,
    this.color,
    this.link,
    this.text,
  });
}
