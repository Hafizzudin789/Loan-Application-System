import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/logout_view.dart';
import 'package:loan_application_system/view/widgets/footer.dart';
import 'package:loan_application_system/view/widgets/stateful_wrapper_widget.dart';
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
          child: SafeArea(
            child: Row(
              children: [
                _customSideNavBar(viewModel),
                Expanded(
                  child: Column(
                    children: [
                      viewModel.layoutViewIndex == LayoutViewIndex.profileView
                          ? const SizedBox()
                          : _customAppBar(viewModel),
                      _body(viewModel),
                      viewModel.layoutViewIndex == LayoutViewIndex.profileView
                          ? const SizedBox()
                          : const Footer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onInit: () {
            Future.delayed(
              const Duration(seconds: 10), () {
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
                              const Text("Your session will expire in 00:45", style: TextStyle(fontSize: xl, fontWeight: FontWeight.w600, color: warningColor),),
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
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogoutView(isSessionExpired: true,)), (route) => false);
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
            },
            );
          },
        )
      ),
    );
  }

  Widget _customSideNavBar(LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.085,
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 15),
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          contentPadding: EdgeInsets.zero,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Expanded(child: Text("Which one would you like to create?", style: TextStyle(color: blackColor, fontSize: xxl, fontWeight: FontWeight.w700),)),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close,
                                          color: blackColor, size: 30),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 0),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _cardTypeWidget("Credit Card", "assets/discountIcon.svg", const Color(0XFF5CD2D0), const Color(0XFF5CD2D0).withOpacity(0.1), _showCardOptionsDetail, viewModel),
                                    const SizedBox(width: 15),
                                    _cardTypeWidget("Auto Finance", "assets/carIcon.svg", yellowColor, const Color(0XFFFFFBED), _showFinanceDetail, viewModel),
                                    const SizedBox(width: 15),
                                    _cardTypeWidget("Personal Finance", "assets/financeIcon.svg", const Color(0XFF0590FF), const Color(0XFF0590FF).withOpacity(0.1), _showPersonalFinanceDetail, viewModel),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
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
        );
      }
    );
  }

  Widget _cardTypeWidget(String label, String imagePath, Color iconBackgroundColor,Color cardColor, Function onTap, LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            onTap(context, viewModel);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: cardColor,
              border: Border.all(color: borderGreyColor, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBackgroundColor,
                    border: Border.all(color: borderGreyColor, width: 1),
                  ),
                  child: SvgPicture.asset(
                    imagePath,
                    color: Colors.white,
                  ),
                ),
                Text(label, style: Theme.of(context).textTheme.headline3,),
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

  Widget _customAppBar(LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            children: [
              Text("Dashboard", style: Theme.of(context).textTheme.headline1,),
              const SizedBox(width: 40),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(blackColor),
                ),
                child: Row(
                  children: const [
                    Text("All Product", style: TextStyle(fontWeight: FontWeight.w700),),
                    SizedBox(width: 10),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 20,)
                  ],
                ),
              ),

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
                    viewModel.changeLayoutViewIndex(LayoutViewIndex.profileView);
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
                        Text("Account Settings", style: TextStyle(color: blackColor, fontSize: m, fontWeight: FontWeight.w700),),
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
    );
  }

  Widget _body(LayoutViewModel viewModel) {
    return Expanded(child: Stack(
      children: [
        viewModel.buildOffstageNavigator(LayoutViewIndex.dashboardView),
        viewModel.buildOffstageNavigator(LayoutViewIndex.applicationsView),
        viewModel.buildOffstageNavigator(LayoutViewIndex.third),
        viewModel.buildOffstageNavigator(LayoutViewIndex.fourth),
        viewModel.buildOffstageNavigator(LayoutViewIndex.profileView),
      ],
    ));
  }

  void _showCardOptionsDetail(BuildContext context, LayoutViewModel viewModel) {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.55,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                        child: Row(
                          children: [
                            Expanded(child: Text("Let’s find the right card for you", style: Theme.of(context).textTheme.headline2,)),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                viewModel.disposeCardResource();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SvgPicture.asset("assets/closeIcon.svg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 0,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Monthly Income", style: Theme.of(context).textTheme.bodyText1,),
                                      TextField(
                                        controller: viewModel.monthlyIncomeTEC,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [LengthLimitingTextInputFormatter(12)],
                                        onChanged: (value){
                                          if(value.isEmpty) {
                                            setState(() {
                                              viewModel.disposeCardResource();
                                            });
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          hintText: "0.00 BHD",
                                          hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Minimum Settlement Due", style: Theme.of(context).textTheme.bodyText1,),
                                      TextField(
                                        controller: viewModel.minimumSettlementTEC,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          hintText: "Please select",
                                          hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            Text("Type of Customer", style: Theme.of(context).textTheme.bodyText1,),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    value: CustomerType.existing,
                                    groupValue: viewModel.customerType,
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    onChanged: viewModel.monthlyIncomeTEC.text.isEmpty
                                        ? null
                                        : (CustomerType? value) {
                                            setState(() {
                                              viewModel.selectCustomerType(value);
                                            });
                                          },
                                    title: Text("Existing", style: Theme.of(context).textTheme.headline3,),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    value: CustomerType.newCustomer,
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    groupValue: viewModel.customerType,
                                    onChanged: viewModel.monthlyIncomeTEC.text.isEmpty
                                        ? null:(CustomerType? value) {
                                      setState(() {
                                        viewModel.selectCustomerType(value);
                                      });
                                    },
                                    title: Text("New Customer", style: Theme.of(context).textTheme.headline3,),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            Text("Card Preferences", style: Theme.of(context).textTheme.bodyText1,),
                            CheckboxListTile(
                              value: viewModel.allCardPrefSelected,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text("Select all", style: Theme.of(context).textTheme.headline3,),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: viewModel.monthlyIncomeTEC.text.isEmpty
                                  ? null:(bool? value) {
                                setState((){
                                  viewModel.selectAllCardPref(value);
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 15,
                              runSpacing: 20,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                _cardPreferenceWidget("Travel Insurance", "assets/aeroplaneIcon.svg", 0, viewModel, setState),
                                _cardPreferenceWidget("Medical Insurance", "assets/medicalIcon.svg", 1, viewModel, setState),
                                _cardPreferenceWidget("Lifestyle Dining / Hotels", "assets/carIcon.svg", 2, viewModel, setState),
                                _cardPreferenceWidget("Golf", "assets/golfIcon.svg", 3, viewModel, setState),
                                _cardPreferenceWidget("Loyalty Rewards", "assets/giftIcon.svg", 4, viewModel, setState),
                                _cardPreferenceWidget("Airport Lounge Access", "assets/flowerIcon.svg", 5, viewModel, setState),
                                _cardPreferenceWidget("Sharia Compliant", "assets/moonIcon.svg", 6, viewModel, setState),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(blackColor),
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                  ),
                                  child: const Text("View all card", style: TextStyle(fontWeight: FontWeight.w700),),
                                ),
                                ElevatedButton(
                                  onPressed:
                                      viewModel.monthlyIncomeTEC.text.isEmpty
                                          ? null
                                          : () {},
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),)),
                                    backgroundColor: MaterialStateProperty.all(idleGreyColor),
                                    foregroundColor: MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                  ),
                                  child: const Text("Show Card", style: TextStyle(fontWeight: FontWeight.w700),),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _cardPreferenceWidget(String label, String imagePath, int index, LayoutViewModel viewModel, Function setState) {
    return Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: viewModel.monthlyIncomeTEC.text.isEmpty
                    ? null:() {
                  setState(() {
                    viewModel.selectCardPref(index);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryGrey, width: 1,),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: viewModel.cardPrefList[index]?Colors.red:darkGreyColor,
                        border: Border.all(color: viewModel.cardPrefList[index]?Colors.red:borderGreyColor, width: 1)
                    ),
                    child: SvgPicture.asset(imagePath, color: Colors.white,),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(label, style: const TextStyle(color: Color(0XFF455666), fontSize: s-1,),)
            ],
          );
        }
    );
  }

  void _showFinanceDetail(BuildContext context, LayoutViewModel viewModel) {}

  void _showPersonalFinanceDetail(BuildContext context, LayoutViewModel viewModel) {}
}
