import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:stacked/stacked.dart';

class CardSelectionPage extends ViewModelWidget<ApplicationFormViewModel> {
  const CardSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ApplicationFormViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Sorry, Faisal Saeed is not eligible for",
                      style: TextStyle(fontSize: xxl, color: blackColorMono, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                      children: [
                        TextSpan(text: " Digibanc\nCash Back Platinum MasterCard", style: TextStyle(fontSize: xxl, color: primaryColor, fontWeight: FontWeight.w500, letterSpacing: 0.5))
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04),
                  const Text("Here’s other credit card eligible for Faisal Saeed", style: TextStyle(fontSize: xl, color: blackColorMono, fontWeight: FontWeight.w600), textAlign: TextAlign.start,),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.54,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 100),
                itemCount: Data.cardSelection.length,
                itemBuilder: (context, index) {
                  return _cardWidget(Data.cardSelection[index], viewModel, index);
                },
              ),
            ),
          ],
        ),
      ),
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
              border: Border.all(color: primaryGrey, width: 1),
              color: Colors.white
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
                    viewModel.changeApplicationFormState(ApplicationFormState.documents);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),)),
                    backgroundColor: MaterialStateProperty.all(successColor),
                    foregroundColor: MaterialStateProperty.all(blackColorMono),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20)),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
