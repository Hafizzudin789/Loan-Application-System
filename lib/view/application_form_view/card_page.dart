import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/selected_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';

class CardPage extends StatelessWidget {
  final List<CardTypeData> cardData;
  final ApplicationFormViewModel viewModel;
  const CardPage({Key? key, required this.cardData, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Card Page",
                style: TextStyle(
                    color: blackColorMono,
                    fontSize: xxl,
                    fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    "assets/closeIcon.svg",
                    width: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
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
                      ElevatedButton(
                        onPressed: () {},
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
                      ),
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
