import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/enums.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKeyGlobal = GlobalKey<NavigatorState>();

  LayoutViewIndex layoutIndex = LayoutViewIndex.dashboardView;

  Map<String,GlobalKey<NavigatorState>> navigatorKeys = {
    LayoutViewIndex.dashboardView.name : GlobalKey<NavigatorState>(),
    LayoutViewIndex.applicationsView.name: GlobalKey<NavigatorState>(),
    LayoutViewIndex.third.name: GlobalKey<NavigatorState>(),
    LayoutViewIndex.fourth.name: GlobalKey<NavigatorState>(),
    LayoutViewIndex.customersListView.name: GlobalKey<NavigatorState>(),
  };

  navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKeys[layoutIndex.name]!.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  navigateToAndBack(String routeName, {dynamic arguments}) {
    return navigatorKeys[layoutIndex.name]!.currentState!.pushNamed(routeName, arguments: arguments);
  }

  navigateAndRemoveAll(String routeName, {dynamic arguments}) {
    return navigatorKeys[layoutIndex.name]!.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  goBack() {
    return navigatorKeys[layoutIndex.name]!.currentState!.pop();
  }


  ////////Global///////
  navigateAndRemoveAllGlobal(String routeName, {dynamic arguments}) {
    return navigatorKeyGlobal.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  navigateToAndBackGlobal(String routeName, {dynamic arguments}) {
    return navigatorKeyGlobal.currentState!.pushNamed(routeName, arguments: arguments);
  }

  navigateToGlobal(String routeName, {dynamic arguments}) {
    return navigatorKeyGlobal.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }


  goBackGlobal() {
    return navigatorKeyGlobal.currentState!.pop();
  }

}