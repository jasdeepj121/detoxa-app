import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/dataModels/top_home_shortcuts.dart';
import 'package:flutter/material.dart';

const Color kChildTrackerColor = AppColors.secondary;
const Color kConsultationColor = Colors.yellow;
const Color kSubscriptionColor = Colors.purple;

class ShortcutsData {
  final List<HomeTopMainShortcuts> homeTopShortcuts = [
    HomeTopMainShortcuts(
      assetName: "",
      color: kChildTrackerColor,
      text: "Child Tracker",
      subShortcuts: [
        HomeTopSubShortcuts(
          assetName: "",
          color: kChildTrackerColor,
          link: "",
          text: "Development Tracker",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kChildTrackerColor,
          link: "",
          text: "Vaccination Tracker",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kChildTrackerColor,
          link: "",
          text: "Growth Tracker",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kChildTrackerColor,
          link: "",
          text: "Eyesight Tracker",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kChildTrackerColor,
          link: "",
          text: "Food Tracker",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kChildTrackerColor,
          link: "",
          text: "Hand & Eye Tracker",
        ),
      ],
    ),
    HomeTopMainShortcuts(
      assetName: "",
      color: kSubscriptionColor,
      text: "Subscribe Now",
      subShortcuts: [
        HomeTopSubShortcuts(
          assetName: "",
          color: kSubscriptionColor,
          link: "",
          text: "Parent",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kSubscriptionColor,
          link: "",
          text: "Corporate",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kSubscriptionColor,
          link: "",
          text: "School",
        ),
        HomeTopSubShortcuts(
          assetName: "",
          color: kSubscriptionColor,
          link: "",
          text: "Society",
        ),
      ],
    ),
    HomeTopMainShortcuts(
      assetName: "",
      color: kConsultationColor,
      text: "Book Consultation",
      subShortcuts: [],
    ),
  ];
}
