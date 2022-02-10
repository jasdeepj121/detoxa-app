import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/child.dart';
import 'package:detoxa/dataModels/new_growth_tracker.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/tracker/tracker_service.dart';
import 'package:flutter/material.dart';

class DownloadReportCard extends StatefulWidget {
  final int childId;
  final int reportId;
  const DownloadReportCard({
    Key key,
    @required this.childId,
    this.reportId,
  }) : super(key: key);

  @override
  _DownloadReportCardState createState() => _DownloadReportCardState();
}

class _DownloadReportCardState extends State<DownloadReportCard> {
  final NavigationService _navigationService = locator<NavigationService>();
  final TrackerService _trackerService = locator<TrackerService>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getDownloadUrl();
  }

  void getDownloadUrl() {
    try {
      // _trackerService.downloadGrowthTrackerResult(
      //     widget.childId, widget.reportId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Download Report"),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          // onPressed: _isLoading ? null : () {},
          onPressed: _navigationService.pop,
          child: const Text("Okay"),
        )
      ],
    );
  }
}
