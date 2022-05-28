// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:loan_application_system/utils/color_constant.dart';
// import 'package:loan_application_system/view_model/layout_view_model.dart';
// import 'package:stacked/stacked.dart';
//
// class CustomSideNavBar extends ViewModelWidget<LayoutViewModel> {
//   const CustomSideNavBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, LayoutViewModel viewModel) {
//     return Builder(
//         builder: (context) {
//           return Container(
//             color: Colors.white,
//             width: MediaQuery.of(context).size.width * 0.085,
//             padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 15),
//             child: Column(
//               children: [
//                 ShaderMask(
//                   shaderCallback: (bounds) {
//                     return const RadialGradient(
//                       center: Alignment.topCenter,
//                       radius: 1,
//                       colors: [Color(0XFF9B1B7F), primaryColor],
//                       tileMode: TileMode.mirror,
//                     ).createShader(bounds);
//                   },
//                   child: SvgPicture.asset("assets/logo.svg"),
//                 ),
//                 const SizedBox(height: 30),
//                 Container(
//                   decoration: const BoxDecoration(
//                     color: primaryColor,
//                     shape: BoxShape.circle,
//                   ),
//                   alignment: Alignment.center,
//                   child: IconButton(
//                     onPressed: () {},
//                     tooltip: "Request application",
//                     icon: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     color: primaryGrey,
//                     borderRadius: BorderRadius.circular(100.0),
//                     // shape: BoxShape.circle
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       _navBarButtonWidget("assets/dashboardIcon.svg", viewModel, LayoutViewIndex.dashboardView),
//                       const SizedBox(height: 10),
//                       _navBarButtonWidget("assets/applicationsIcon.svg", viewModel, LayoutViewIndex.applicationsView),
//                       const SizedBox(height: 10),
//                       _navBarButtonWidget("assets/pieChart.svg", viewModel, LayoutViewIndex.third),
//                       const SizedBox(height: 10),
//                       _navBarButtonWidget("assets/searchIcon.svg", viewModel, LayoutViewIndex.fourth),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 const Expanded(child: SizedBox()),
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: const BoxDecoration(
//                     color: lightGreyColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: SvgPicture.asset("assets/messageIcon.svg"),
//                 ),
//               ],
//             ),
//           );
//         }
//     );
//   }
//
//   Widget _navBarButtonWidget(String iconPath, LayoutViewModel viewModel, LayoutViewIndex value) {
//     return InkWell(
//       onTap: () {
//         // locator<NavigationService>().navigateTo(
//         //   value == LayoutViewIndex.dashboardView
//         //       ? dashboardView
//         //       : value == LayoutViewIndex.applicationsView
//         //           ? applicationView
//         //           : value == LayoutViewIndex.third
//         //               ? thirdView
//         //               : fourthView,
//         // );
//         viewModel.changeLayoutViewIndex(value);
//       },
//       child: Container(
//         padding: const EdgeInsets.all(13),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: value == viewModel.layoutViewIndex
//               ? Colors.white
//               : Colors.transparent,
//           border: Border.all(color: value == viewModel.layoutViewIndex?borderGreyColor: Colors.transparent),
//         ),
//         child: SvgPicture.asset(
//           iconPath,
//           color: value == viewModel.layoutViewIndex
//               ? primaryColor
//               : const Color(0XFF6F7C89),
//         ),
//       ),
//     );
//   }
// }
