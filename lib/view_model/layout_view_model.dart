import 'package:flutter/material.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/layout_view/tab_navigator_Widget.dart';
import 'package:stacked/stacked.dart';

class LayoutViewModel extends BaseViewModel {

  LayoutViewIndex _layoutViewIndex = LayoutViewIndex.dashboardView;
  LayoutViewIndex get layoutViewIndex => _layoutViewIndex;

  changeLayoutViewIndex(LayoutViewIndex value) async{
    // //if press the same bottom navbar item pop if can
    if(_layoutViewIndex == value) {
      await locator<NavigationService>().navigatorKeys[_layoutViewIndex.name]!.currentState!.maybePop();
    return;
    }
    _layoutViewIndex = value;
    locator<NavigationService>().layoutIndex = value;
    notifyListeners();
  }

  justChangeLayoutViewIndex(LayoutViewIndex value) {
    _layoutViewIndex = value;
    locator<NavigationService>().layoutIndex = value;
  }

  buildOffstageNavigator(LayoutViewIndex layoutIndex) {
    return Offstage(
      offstage: _layoutViewIndex != layoutIndex,
      child: TabNavigator(
        navigatorKey: locator<NavigationService>().navigatorKeys[layoutIndex.name]!,
        bottomIndex: layoutIndex,
      ),
    );
  }
}