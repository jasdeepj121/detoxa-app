import 'package:detoxa/ui/routes/home_page/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, HomePageViewModel model, _) {
        return Scaffold(
          appBar: AppBar(),
          drawer: Container(
            width: 250,
            child: Drawer(
              child: Container(
                color: primaryColor,
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}
