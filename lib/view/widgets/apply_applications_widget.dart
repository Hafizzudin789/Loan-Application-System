import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/services/routing_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/selected_widget.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';

showApplyApplicationsPopUp(BuildContext context, LayoutViewModel viewModel) {
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
                  const Expanded(child: Text("Which one would you like to create?", style: TextStyle(color: blackColorMono, fontSize: xxl, fontWeight: FontWeight.w700),)),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close,
                        color: blackColorMono, size: 30),
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
                  _cardTypeWidget("Credit Card", "assets/discountIcon.svg", const Color(0XFF5CD2D0), const Color(0XFF5CD2D0).withOpacity(0.1), showCardOptionsDetail, viewModel),
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

void showCardOptionsDetail(BuildContext context, LayoutViewModel viewModel) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.55,
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: MediaQuery.of(context).size.height*0.01, top: MediaQuery.of(context).size.height*0.01),
                      child: Row(
                        children: [
                          Expanded(child: Text("Let's find the right card for you", style: Theme.of(context).textTheme.headline2,)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              viewModel.disposeCardResource();
                            },
                            child: Padding(
                              // padding: const EdgeInsets.only(left: 2.0, right: 20),
                              padding: const EdgeInsets.all(20),
                              child: SvgPicture.asset("assets/closeIcon.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.02),

                          Text("Type of Customer", style: Theme.of(context).textTheme.bodyText1,),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap:
                                  // viewModel.monthlyIncomeTEC.text.isEmpty
                                  //     ? null
                                  //     :
                                      () {
                                    setState((){
                                      viewModel.selectCustomerType(CustomerType.newCustomer);
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02),
                                    child: Row(
                                      children: [
                                        SelectedWidget(isSelected: viewModel.customerType == CustomerType.newCustomer),
                                        const SizedBox(width: 15),
                                        Text("New Customer", style: Theme.of(context).textTheme.headline3,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap:
                                  // viewModel.monthlyIncomeTEC.text.isEmpty
                                  //     ? null
                                  //     :
                                      () {
                                    setState((){
                                      viewModel.selectCustomerType(CustomerType.existing);
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02),
                                    child: Row(
                                      children: [
                                        SelectedWidget(isSelected: viewModel.customerType == CustomerType.existing),
                                        const SizedBox(width: 15),
                                        Text("Existing", style: Theme.of(context).textTheme.headline3,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          viewModel.customerType == CustomerType.existing
                              ? Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Customer ID Type", style: Theme.of(context).textTheme.bodyText1,),
                                              const SizedBox(height: 4),
                                              PopupMenuButton<String>(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                offset: const Offset(0, 40),
                                                itemBuilder: (context) => viewModel.customerIdTypeList.map(
                                                      (e) => PopupMenuItem<String>(
                                                      value: e,
                                                      child: Text(e),
                                                    ),
                                                ).toList(),
                                                onSelected: (String value) {
                                                  setState(() {
                                                    viewModel.customerIdType = value;
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(bottom: 6.0, top: 4),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          viewModel.customerIdType??"Please select",
                                                          style: const TextStyle(fontWeight: FontWeight.w700, color: blackColorMono),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Icon(
                                                        Icons.keyboard_arrow_down,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(height: 1, color: idleGreyColor,),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Customer ID number", style: Theme.of(context).textTheme.bodyText1,),
                                              TextField(
                                                controller: viewModel.customerIdNumberTEC,
                                                keyboardType: TextInputType.number,
                                                style: const TextStyle(fontWeight: FontWeight.w700),
                                                decoration: const InputDecoration(
                                                  isDense: true,
                                                  hintText: "Enter ID number",
                                                  hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                                ),
                                                onChanged: (value) {
                                                  setState((){});
                                                },
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          SizedBox(height: MediaQuery.of(context).size.height*0.02),

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
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                                      onTap: () {
                                        if(viewModel.monthlyIncomeTEC.text.isEmpty) {
                                          setState(() {
                                            viewModel.monthlyIncomeTEC.text = "BHD ";
                                            viewModel.monthlyIncomeTEC.selection = TextSelection.fromPosition(TextPosition(offset: viewModel.monthlyIncomeTEC.text.length));
                                          });
                                        }
                                      },
                                      onChanged: (value){
                                        if(value.isEmpty) {
                                          setState(() {
                                            // viewModel.disposeCardResource();
                                            viewModel.dropdownValue = '25 %';
                                            viewModel.selectAllCardPref(false);
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
                                    const SizedBox(height: 4),

                                    PopupMenuButton<String>(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      offset: const Offset(0, 40),
                                      itemBuilder: (context) => viewModel.items.map(
                                            (e) => PopupMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      ).toList(),
                                      onSelected: (String value) {
                                        setState(() {
                                          viewModel.dropdownValue = value;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 6.0, top: 4),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                viewModel.dropdownValue,
                                                style: const TextStyle(fontWeight: FontWeight.w700, color: blackColorMono),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(height: 1, color: idleGreyColor,),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // const SizedBox(height: 30),
                          SizedBox(height: MediaQuery.of(context).size.height*0.04),

                          Text("Card Preferences", style: Theme.of(context).textTheme.bodyText1,),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01),
                          InkWell(
                            onTap: viewModel.monthlyIncomeTEC.text.isEmpty
                                ? null
                                : () {
                              setState(() {
                                viewModel.selectAllCardPref(!viewModel.allCardPrefSelected);
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SelectedWidget(isSelected: viewModel.allCardPrefSelected),
                                  const SizedBox(width: 15),
                                  Text("Select all", style: Theme.of(context).textTheme.headline3,),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01),
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
                          SizedBox(height: MediaQuery.of(context).size.height*0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: (viewModel.customerType == CustomerType.newCustomer && viewModel.monthlyIncomeTEC.text.isNotEmpty && viewModel.cardPrefList.contains(true))
                                    ||(viewModel.customerType == CustomerType.existing && (viewModel.customerIdType == null || viewModel.customerIdNumberTEC.text.isEmpty))
                                    || (viewModel.customerType == CustomerType.existing && viewModel.monthlyIncomeTEC.text.isNotEmpty && viewModel.cardPrefList.contains(true) &&  viewModel.customerIdType != null && viewModel.customerIdNumberTEC.text.isNotEmpty)
                                    ? null
                                    : () {
                                        Navigator.pop(context);
                                        locator<NavigationService>().navigateToAndBack(applicationFormView, arguments: Data.cardTypeData);
                                        // viewModel.disposeCardResource();
                                      },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all((viewModel.customerType == CustomerType.newCustomer && viewModel.monthlyIncomeTEC.text.isNotEmpty && viewModel.cardPrefList.contains(true))
                                      ||(viewModel.customerType == CustomerType.existing && (viewModel.customerIdType == null || viewModel.customerIdNumberTEC.text.isEmpty))
                                      ||(viewModel.customerType == CustomerType.existing && viewModel.monthlyIncomeTEC.text.isNotEmpty && viewModel.cardPrefList.contains(true) &&  viewModel.customerIdType != null && viewModel.customerIdNumberTEC.text.isNotEmpty)
                                      ? greyColor:blackColorMono),
                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                ),
                                child: const Text("View all card", style: TextStyle(fontWeight: FontWeight.w700),),
                              ),
                              ElevatedButton(
                                onPressed:
                                viewModel.monthlyIncomeTEC.text.isEmpty
                                    ? null
                                    : () {
                                  Navigator.pop(context);
                                  locator<NavigationService>().navigateToAndBack(applicationFormView, arguments: Data.limitedCardData);
                                  // viewModel.disposeCardResource();
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),)),
                                  backgroundColor: MaterialStateProperty.all(
                                    viewModel.monthlyIncomeTEC.text.isNotEmpty  && viewModel.cardPrefList.contains(true)
                                        ? successColor
                                        : idleGreyColor,
                                  ),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                ),
                                child: Text(
                                  viewModel.monthlyIncomeTEC.text.isNotEmpty && viewModel.cardPrefList.contains(true)
                                      ? "Show 2 Card"
                                      : "Show Card",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02),
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
              borderRadius: BorderRadius.circular(16),
              onTap: viewModel.monthlyIncomeTEC.text.isEmpty
                  ? null:() {
                setState(() {
                  viewModel.selectCardPref(index);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  border: Border.all(color: viewModel.cardPrefList[index]?primaryColor.withOpacity(0.2): borderGreyColor, width: 1,),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: viewModel.cardPrefList[index]?primaryColor:darkGreyColor,
                      border: Border.all(color: borderGreyColor, width: 1)
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
