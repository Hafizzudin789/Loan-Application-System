import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/view/application_form_view/application_form_view.dart';
import 'package:loan_application_system/view/application_form_view/scan_id_view.dart';
import 'package:loan_application_system/view/applications_view.dart';
import 'package:loan_application_system/view/auth_view/logout_view.dart';
import 'package:loan_application_system/view/customer_list_view.dart';
import 'package:loan_application_system/view/dashboard_view.dart';
import 'package:loan_application_system/view/layout_view/layout_view.dart';
import 'package:loan_application_system/view/profile_view/profile_view.dart';
import 'package:loan_application_system/view/splash_view.dart';


const String splashView = "splash-view";
const String dashboardView = "dashboard-view";
const String applicationView = "application-view";
const String thirdView = "third-view";
const String fourthView = "fourth-view";
const String layoutView = "layout-view";
const String profileView = "profile-view";
const String applicationFormView = "application-form-view";
const String logoutView = "logout-view";
const String scanIdView = "scan-id-view";
const String customerListView = "customer-list-view";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashView:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case layoutView:
      return MaterialPageRoute(builder: (context) => const LayoutView());
    case dashboardView:
      return MaterialPageRoute(builder: (context) => const DashboardView());
    case applicationView:
      return MaterialPageRoute(builder: (context) => const ApplicationsView());
    case thirdView:
      return MaterialPageRoute(builder: (context) => const Center(child: Text("Hello"),));
    case fourthView:
      return MaterialPageRoute(builder: (context) => const Center(child: Text("World"),));
    case profileView:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    case applicationFormView:
      List<CardTypeData> data = settings.arguments as List<CardTypeData>;
      return MaterialPageRoute(builder: (context) => ApplicationFormView(cardData: data,));
    case logoutView:
      bool value = settings.arguments as bool;
      return MaterialPageRoute(builder: (context) => LogoutView(isSessionExpired: value));
    case scanIdView:
      String value = (settings.arguments as List)[0];
      Timer timer = (settings.arguments as List)[1];
      return MaterialPageRoute(builder: (context) => ScanIdView(textValue: value, timer: timer,));
    case customerListView:
      return MaterialPageRoute(builder: (context) => const CustomerListView());
    default:
      return MaterialPageRoute(builder: (context) => Material(child: Center(child: Text("No Such Route ${settings.name}"),)));
  }
}