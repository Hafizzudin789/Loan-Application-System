import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/logout_view.dart';
import 'package:loan_application_system/view/widgets/apply_applications_widget.dart';
import 'package:loan_application_system/view/widgets/stateful_wrapper_widget.dart';
import 'package:loan_application_system/view/widgets/timer_widget.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';


class LayoutView extends ViewModelWidget<LayoutViewModel> {
  const LayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async =>
      !await locator<NavigationService>().navigatorKeys[locator<NavigationService>().layoutIndex.name]!.currentState!.maybePop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body : StatefulWrapper(
          child: Row(
            children: [
              _customSideNavBar(viewModel),
              Expanded(
                child: SafeArea(child: _body(viewModel)),
              ),
            ],
          ),
          onInit: () {
            viewModel.timerForSession = Timer.periodic(const Duration(minutes: 18), (timer) {
              timer.cancel();
              _showSessionExpirePopUp(context);
            });
          },
          onDispose: () {
            viewModel.timerForSession.cancel();
          },
        )
      ),
    );
  }


  void _showSessionExpirePopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("assets/closeIcon.svg", height: 15, width: 15),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: borderGreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error_outline,
                          color: warningColor),
                    ),
                    const SizedBox(height: 30),
                    const TimerWidget(),
                    const SizedBox(height: 5),
                    const Text("Tap ‘Okay’ to stay logged in or click ‘Log out’ to log out.", style: TextStyle(fontSize: m, fontWeight: FontWeight.w500, color: darkGreyColor),),
                    const SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(errorColor),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                            side: MaterialStateProperty.all(const BorderSide(color: errorColor)),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogoutView(isSessionExpired: false,)), (route) => false);
                          },
                          child: const Text("Log out", style: TextStyle(fontWeight: FontWeight.w700),),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(primaryColor),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20))
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Okay", style: TextStyle(fontWeight: FontWeight.w700),),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _customSideNavBar(LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.085,
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 15),
          child: SafeArea(
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const RadialGradient(
                      center: Alignment.topCenter,
                      radius: 1,
                      colors: [Color(0XFF9B1B7F), primaryColor],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: SvgPicture.asset("assets/logo.svg"),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      showApplyApplicationsPopUp(context, viewModel);
                    },
                    tooltip: "Request application",
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: primaryGrey,
                    borderRadius: BorderRadius.circular(100.0),
                    // shape: BoxShape.circle
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _navBarButtonWidget("assets/dashboardIcon.svg", viewModel, LayoutViewIndex.dashboardView),
                      const SizedBox(height: 10),
                      _navBarButtonWidget("assets/applicationsIcon.svg", viewModel, LayoutViewIndex.applicationsView),
                      const SizedBox(height: 10),
                      _navBarButtonWidget("assets/pieChart.svg", viewModel, LayoutViewIndex.third),
                      const SizedBox(height: 10),
                      _navBarButtonWidget("assets/searchIcon.svg", viewModel, LayoutViewIndex.fourth),
                      const SizedBox(height: 10),
                      _navBarButtonWidget("assets/customerProfile.svg", viewModel, LayoutViewIndex.customersListView),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: lightGreyColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/messageIcon.svg"),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _navBarButtonWidget(String iconPath, LayoutViewModel viewModel, LayoutViewIndex value) {
    return InkWell(
      onTap: () {
        viewModel.changeLayoutViewIndex(value);
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value == viewModel.layoutViewIndex
              ? Colors.white
              : Colors.transparent,
          border: Border.all(color: value == viewModel.layoutViewIndex?borderGreyColor: Colors.transparent),
        ),
        child: SvgPicture.asset(
          iconPath,
          color: value == viewModel.layoutViewIndex
              ? primaryColor
              : const Color(0XFF6F7C89),
        ),
      ),
    );
  }

  Widget _body(LayoutViewModel viewModel) {
    return Stack(
      children: [
        viewModel.buildOffstageNavigator(LayoutViewIndex.dashboardView),
        viewModel.buildOffstageNavigator(LayoutViewIndex.applicationsView),
        viewModel.buildOffstageNavigator(LayoutViewIndex.third),
        viewModel.buildOffstageNavigator(LayoutViewIndex.fourth),
        viewModel.buildOffstageNavigator(LayoutViewIndex.customersListView),
      ],
    );
  }

}
