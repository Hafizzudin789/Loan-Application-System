import 'package:stacked/stacked.dart';

enum LayoutViewIndex {
  dashboardView,
  applicationsView,
  third,
  fourth;
}

enum PopupMenuState {
  account,
  logout,
}

class LayoutViewModel extends BaseViewModel {

  LayoutViewIndex _layoutViewIndex = LayoutViewIndex.dashboardView;
  LayoutViewIndex get layoutViewIndex => _layoutViewIndex;

  changeLayoutViewIndex(LayoutViewIndex value) {
    _layoutViewIndex = value;
    notifyListeners();
  }
}