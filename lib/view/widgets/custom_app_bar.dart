import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/services/routing_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/logout_view.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomAppBar extends ViewModelWidget<LayoutViewModel> {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Text(
            viewModel.layoutViewIndex == LayoutViewIndex.dashboardView
                ? "Dashboard"
                : "Applications",
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(width: 40),
          viewModel.layoutViewIndex == LayoutViewIndex.dashboardView
              ? ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: borderGreyColor))),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(blackColorMono),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "All Product",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                      )
                    ],
                  ),
                )
              : const SizedBox(),

          const Expanded(child: SizedBox()),

          const Text("14 December 2021", style: TextStyle(fontSize: s),),
          const SizedBox(width: 25),
          SvgPicture.asset("assets/settingsIcon.svg", height: 20),
          const SizedBox(width: 25),
          SvgPicture.asset("assets/notificationIcon.svg", height: 20),
          const SizedBox(width: 25),
          PopupMenuButton<PopupMenuState>(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            position: PopupMenuPosition.under,
            onSelected: (value) {
              if(value == PopupMenuState.logout) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogoutView()), (route) => false);
              } else {
                // viewModel.changeLayoutViewIndex(LayoutViewIndex.profileView);
                locator<NavigationService>().navigateToAndBack(profileView);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryDarkGrey,
              ),
              child: const Text("PD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                enabled: false,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("PHILLIP DIAS", style: TextStyle(color: darkGreyColor, fontSize: s, fontWeight: FontWeight.w700, letterSpacing: 1.5),),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 5,
                      runSpacing: 2,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Text("Active", style: TextStyle(fontSize: s, color: Colors.white, fontWeight: FontWeight.w700),),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Text("Sales Officer", style: TextStyle(fontSize: s, color: Colors.white, fontWeight: FontWeight.w700),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: PopupMenuState.account,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Account Settings", style: TextStyle(color: blackColorMono, fontSize: m, fontWeight: FontWeight.w700),),
                    Text("Manage your account", style: TextStyle(color: darkGreyColor, fontSize: s),),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: PopupMenuState.logout,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Text("Log out", style: TextStyle(fontSize: m, color: errorColor, fontWeight: FontWeight.w700),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
