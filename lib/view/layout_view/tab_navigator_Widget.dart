import 'package:flutter/material.dart';
import 'package:loan_application_system/services/routing_service.dart';
import 'package:loan_application_system/utils/enums.dart';


class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final LayoutViewIndex bottomIndex;
  const TabNavigator({Key? key, required this.navigatorKey, required this.bottomIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String childRoute;

    if(bottomIndex == LayoutViewIndex.dashboardView) {
      childRoute = dashboardView;
    } else if(bottomIndex == LayoutViewIndex.applicationsView) {
      childRoute = applicationView;
    } else if(bottomIndex == LayoutViewIndex.third) {
      childRoute = thirdView;
    }
    // else if(bottomIndex == LayoutViewIndex.profileView) {
    //   childRoute = profileView;
    // }
    else {
      childRoute = fourthView;
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: childRoute,
    );
  }
}
