import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/selected_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';


class CardPage extends ViewModelWidget<ApplicationFormViewModel> {
  final List<CardTypeData> cardData;
  const CardPage({Key? key, required this.cardData}) : super(key: key);

  @override
  Widget build(BuildContext context, ApplicationFormViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ElevatedFilterButton(),
                      Text(
                        "${cardData.length} Cards Available",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.54,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ListView.builder(
                        controller: viewModel.scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 100, right: cardData.length<3?0:60),
                        itemCount: cardData.length,
                        itemBuilder: (context, index) {
                          return _cardWidget(cardData[index], viewModel, index);
                        },
                      ),

                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: cardData.length<3?0:1.5,
                              sigmaY: cardData.length<3?0:1.5,
                            ),
                            child: const SizedBox(
                              width: 90,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: cardData.length<3?0:1.5,
                              sigmaY: cardData.length<3?0:1.5,
                            ),
                            child: const SizedBox(
                              width: 90,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 50,
                        child: viewModel.scrollController.hasClients && viewModel.scrollController.offset >
                            viewModel.scrollController.position.minScrollExtent
                            ? InkWell(
                                onTap: () {
                                  viewModel.scrollRight();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderGreyColor, width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: borderGreyColor,
                                          offset: Offset(-0.5, 2),
                                          blurRadius: 0.5,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 15,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Positioned(
                        right: 50,
                        child: (viewModel.scrollController.hasClients && viewModel.scrollController.offset <
                            viewModel.scrollController.position.maxScrollExtent) || cardData.length > 2
                            ? InkWell(
                                onTap: () {
                                  viewModel.scrollLeft();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        color: borderGreyColor, width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: borderGreyColor,
                                          offset: Offset(-0.5, 2),
                                          blurRadius: 0.5,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModel.cardSelected.contains(true)
            ? _progressBar(viewModel)
            : const SizedBox(),
      ],
    );
  }

  Widget _progressBar(ApplicationFormViewModel viewModel) {
    int selectedCardLength = viewModel.cardSelected.where((element) => element == true).length;
    return Builder(
      builder: (context) {
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            LinearProgressIndicator(
              backgroundColor: borderGreyColor,
              value: viewModel.progressValue,
              valueColor: const AlwaysStoppedAnimation<Color>(successColor),
              minHeight: 2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectedWidget(isSelected: selectedCardLength == viewModel.cardSelected.length),
                  const SizedBox(width: 10),
                  Expanded(
                    child: selectedCardLength == 1
                        ? Text("$selectedCardLength card selected", style: const TextStyle(color: blackColorMono, fontWeight: FontWeight.w700),)
                        : Text("$selectedCardLength cards selected", style: const TextStyle(color: blackColorMono, fontWeight: FontWeight.w700),),
                  ),
                  ElevatedButton(
                    onPressed: viewModel.cardSelected.contains(true) ? () {
                      viewModel.changeApplicationFormState(ApplicationFormState.customerId);
                    } : null,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(color: borderGreyColor))),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(blackColorMono),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20)),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontWeight: FontWeight.w700, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        );
      }
    );
  }

  Widget _cardWidget(CardTypeData cardTypeData, ApplicationFormViewModel viewModel, int index) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(right: 20),
          width: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: viewModel.cardSelected[index]?const Color(0XFFD64951).withOpacity(0.2): primaryGrey, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomRight,
                constraints: BoxConstraints.tight(Size(double.infinity, MediaQuery.of(context).size.height * 0.16)),
                decoration: BoxDecoration(
                  color: cardTypeData.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  gradient: cardTypeData.cardColor != null
                      ? null
                      : const LinearGradient(
                          colors: [errorColor, primaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                ),
                child: Image.asset(cardTypeData.cardType),
              ),
              const SizedBox(height: 20),
              Text(
                cardTypeData.label,
                style: const TextStyle(
                    color: blackColorMono,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    height: 1.3),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Minimum Income",
                          style: TextStyle(color: darkGreyColor, fontSize: s - 1),
                        ),
                        Text(
                          cardTypeData.minimumIncome.toString(),
                          style: const TextStyle(color: blackColorPrimary),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Features",
                          style: TextStyle(color: darkGreyColor, fontSize: s - 1),
                        ),
                        Text(
                          cardTypeData.feature,
                          style: const TextStyle(color: blackColorPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Rewards",
                          style: TextStyle(color: darkGreyColor, fontSize: s - 1),
                        ),
                        Text(
                          cardTypeData.rewardsUpTo,
                          style: const TextStyle(color: blackColorPrimary),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Annual Fee",
                          style: TextStyle(color: darkGreyColor, fontSize: s - 1),
                        ),
                        Text(
                          cardTypeData.annualFee,
                          style: const TextStyle(color: blackColorPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {
                  viewModel.selectCard(index);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: viewModel.cardSelected[index]?Colors.transparent:borderGreyColor))),
                  backgroundColor: MaterialStateProperty.all(viewModel.cardSelected[index]?primaryColor:Colors.white),
                  foregroundColor: MaterialStateProperty.all(blackColorMono),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20)),
                ),
                child: viewModel.cardSelected[index]
                    ? Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Select Card",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      )
                    : const Text(
                        "Select Card",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: blackColorMono),
                      ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class ElevatedFilterButton extends ViewModelWidget<LayoutViewModel> {
  const ElevatedFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
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
                                // const SizedBox(height: 20),
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

                                Text("Type of Customer", style: Theme.of(context).textTheme.bodyText1,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: viewModel.monthlyIncomeTEC.text.isEmpty
                                            ? null
                                            : () {
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
                                    Expanded(
                                      child: InkWell(
                                        onTap:
                                        viewModel.monthlyIncomeTEC.text.isEmpty
                                            ? null
                                            : () {
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
                                      // child: RadioListTile(
                                      //   value: CustomerType.newCustomer,
                                      //   contentPadding: EdgeInsets.zero,
                                      //   dense: true,
                                      //   groupValue: viewModel.customerType,
                                      //   onChanged: viewModel.monthlyIncomeTEC.text.isEmpty
                                      //       ? null:(CustomerType? value) {
                                      //     setState(() {
                                      //       viewModel.selectCustomerType(value);
                                      //     });
                                      //   },
                                      //   title: Text("New Customer", style: Theme.of(context).textTheme.headline3,),
                                      // ),
                                    ),
                                  ],
                                ),

                                // const SizedBox(height: 30),
                                SizedBox(height: MediaQuery.of(context).size.height*0.02),

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
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(blackColorMono),
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                  ),
                                  child: const Text("Done", style: TextStyle(fontWeight: FontWeight.w700),),
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
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(
                    color: borderGreyColor))),
        backgroundColor:
        MaterialStateProperty.all(Colors.white),
        foregroundColor:
        MaterialStateProperty.all(blackColorMono),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Filters",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset("assets/filterIcon.svg")
        ],
      ),
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

}
