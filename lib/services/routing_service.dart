import 'package:flutter/material.dart';
import 'package:loan_application_system/data.dart';
import 'package:loan_application_system/view/application_form_view/application_form_view.dart';
import 'package:loan_application_system/view/applications_view.dart';
import 'package:loan_application_system/view/dashboard_view.dart';
import 'package:loan_application_system/view/layout_view/layout_view.dart';
import 'package:loan_application_system/view/profile_view.dart';


const String splashView = "splash-view";
const String dashboardView = "dashboard-view";
const String applicationView = "application-view";
const String thirdView = "third-view";
const String fourthView = "fourth-view";
const String layoutView = "layout-view";
const String profileView = "profile-view";
const String applicationFormView = "application-form-view";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
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
    default:
      return MaterialPageRoute(builder: (context) => Material(child: Center(child: Text("No Such Route ${settings.name}"),)));
  }
}