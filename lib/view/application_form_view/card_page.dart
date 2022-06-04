import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/application_view_model.dart';
import 'package:stacked/stacked.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationViewModel>.reactive(
      viewModelBuilder: () => ApplicationViewModel(),
      builder: (context, viewModel, _) {
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
                          Text("${Data.cardTypeData.length} Cards Available", style: Theme.of(context).textTheme.headline2,),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.54,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 100),
                        itemCount: Data.cardTypeData.length,
                        itemBuilder: (context, index) {
                          return _cardWidget(Data.cardTypeData[index], viewModel);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            viewModel.cardSelected
                ? Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      const LinearProgressIndicator(
                        backgroundColor: borderGreyColor,
                        value: 0.1,
                        valueColor: AlwaysStoppedAnimation<Color>(successColor),
                        minHeight: 2,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: ElevatedButton(
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
                              child: const Text(
                                "Next",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Widget _cardWidget(CardTypeData cardTypeData, ApplicationViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(right: 20),
      width: 228,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardTypeData.borderColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
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
              child: SvgPicture.asset(cardTypeData.cardType),
            ),
          ),
          const SizedBox(height: 20),
          Text(cardTypeData.label, style: const TextStyle(color: blackColorMono, fontWeight: FontWeight.w700, letterSpacing: 0.2, height: 1.3),),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Minimum Income", style: TextStyle(color: darkGreyColor, fontSize: s-1),),
                    Text(cardTypeData.minimumIncome.toString(), style: const TextStyle(color: blackColorPrimary),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Features", style: TextStyle(color: darkGreyColor, fontSize: s-1),),
                    Text(cardTypeData.feature, style: const TextStyle(color: blackColorPrimary),),
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
                    const Text("Rewards", style: TextStyle(color: darkGreyColor, fontSize: s-1),),
                    Text(cardTypeData.rewardsUpTo, style: const TextStyle(color: blackColorPrimary),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Annual Fee", style: TextStyle(color: darkGreyColor, fontSize: s-1),),
                    Text(cardTypeData.annualFee, style: const TextStyle(color: blackColorPrimary),),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              viewModel.selectCard();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(blackColorMono),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
            ),
            child: const Text("Select Card", style: TextStyle(fontWeight: FontWeight.w700),),
          ),
        ],
      ),
    );
  }
}
