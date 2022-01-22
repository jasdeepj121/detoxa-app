import 'package:auto_size_text/auto_size_text.dart';
import 'package:detoxa/app/ui_constants/home_top_shortcuts/shortcuts.dart';
import 'package:detoxa/dataModels/top_home_shortcuts.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  List<HomeTopMainShortcuts> _topShortcuts = [];
  int selectedMainShortcutIndex = 0;
  // int _selectedSubShortcutIndex = -1;
  AutoSizeGroup mainShortcutGroup = AutoSizeGroup();
  AutoSizeGroup subShortcutGroup = AutoSizeGroup();

  List<HomeTopMainShortcuts> get shortcutsData => _topShortcuts ?? [];
  List<HomeTopSubShortcuts> get subShortcutsData =>
      _topShortcuts[selectedMainShortcutIndex]?.subShortcuts ?? [];

  HomePageViewModel() {
    setTopShortCuts();
  }

  void setTopShortCuts() {
    _topShortcuts = ShortcutsData().homeTopShortcuts;
  }

  void updateSelectedMainShortcut(int index) {
    selectedMainShortcutIndex = index;
    notifyListeners();
  }
}
