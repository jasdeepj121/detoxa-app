import 'package:auto_size_text/auto_size_text.dart';
import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:detoxa/ui/routes/home_page/home_page_view_model.dart';
import 'package:detoxa/ui/routes/home_page/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  // int items = 4;
  // int subItems = 6;
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, HomePageViewModel model, _) {
        return Scaffold(
          drawer: Container(
            width: 250,
            child: Drawer(
              child: SideDrawer(),
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                //background,
                Column(
                  children: [
                    SizedBox(height: mediaQuery.padding.top),
                    SizedBox(
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            // vertical: 4.0,
                            horizontal: 12,
                          ),
                          child: Row(
                            children: [
                              Builder(builder: (context) {
                                return IconButton(
                                  onPressed: () =>
                                      Scaffold.of(context).openDrawer(),
                                  icon: const Icon(
                                    Icons.account_circle,
                                    size: 34,
                                    color: AppColors.secondary,
                                  ),
                                );
                              }),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 75,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.shortcutsData.length,
                        itemBuilder: (context, index) {
                          var shortcut = model.shortcutsData[index];
                          return Container(
                            margin: EdgeInsets.only(
                              left: 9,
                              right: (model.shortcutsData.length - 1) == index
                                  ? 9
                                  : 0,
                            ),
                            child: CustomTabItem(
                              text: shortcut.text,
                              assetName: shortcut.assetName,
                              color: shortcut.color,
                              isSelected:
                                  index == model.selectedMainShortcutIndex,
                              onPressed: () =>
                                  model.updateSelectedMainShortcut(index),
                              textGroup: model.mainShortcutGroup,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.subShortcutsData.length,
                        itemBuilder: (context, index) {
                          var shortcut = model.subShortcutsData[index];
                          return Container(
                            margin: EdgeInsets.only(
                              left: 9,
                              right:
                                  (model.subShortcutsData.length - 1) == index
                                      ? 9
                                      : 0,
                            ),
                            child: CustomTabItem(
                              text: shortcut.text,
                              assetName: shortcut.assetName,
                              color: shortcut.color,
                              isSelected: true,
                              textGroup: model.subShortcutGroup,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 250,
                      child: Swiper(
                        itemCount: 5,
                        pagination: 5 > 1
                            ? SwiperPagination(
                                alignment: const Alignment(0, 1.25),
                                builder: SwiperCustomPagination(
                                  builder: (context, config) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          config.itemCount,
                                          (index) => Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: index ==
                                                          config.activeIndex
                                                      ? AppColors.secondary
                                                      : AppColors.primarySwatch,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 3.0,
                                                ),
                                                width: 7,
                                                height: 7,
                                              )),
                                    );
                                  },
                                ),
                              )
                            : null,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 50,
                            // width:150,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.green[(index + 1) * 100],
                          );
                        },
                      ),
                    ),
                    // TabBar(tabs: [Container()]),
                  ],
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}

class CustomTabItem extends StatelessWidget {
  final String text;
  final double width;
  final Color color;
  final String assetName;
  final bool isSelected;
  final Function onPressed;
  final AutoSizeGroup textGroup;
  const CustomTabItem({
    Key key,
    this.text,
    this.width = 130,
    this.assetName,
    this.color,
    this.isSelected,
    this.onPressed,
    this.textGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: color ?? AppColors.secondary,
            // shadowColor: Colors.transparent,
            elevation: 0,
            // primary: AppColors.primarySwatch,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: onPressed,
        child: Container(
          // width: double.maxFinite,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // border: Border.all(),
            borderRadius: BorderRadius.circular(12),
            // color: AppColors.secondary,
            // backgroundBlendMode: BlendMode.luminosity
          ),
          child: Container(
            // alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (isSelected ?? false)
                  ? AppColors.primarySwatch.shade700
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 30,
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.grey,
                  ),
                ),
                // const Expanded(child: SizedBox(width: 0)),
                Flexible(
                  flex: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AutoSizeText(
                        text,
                        minFontSize: 8,
                        maxLines: 2,
                        maxFontSize: 12,
                        softWrap: true,
                        wrapWords: false,
                        style: const TextStyle(
                          color: AppColors.secondary,
                        ),
                        group: textGroup,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
