import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';


class ApplicationFormView extends ViewModelWidget<LayoutViewModel> {
  final List<CardTypeData> cardData;
  const ApplicationFormView({Key? key, required this.cardData}) : super(key: key);


  @override
  Widget build(BuildContext context, LayoutViewModel layoutViewModel) {
    return ViewModelBuilder<ApplicationFormViewModel>.reactive(
      viewModelBuilder: () => ApplicationFormViewModel(),
      onModelReady: (viewModel) {
        viewModel.initializeCardSelectedList(cardData.length);
      },
      onDispose: (viewModel) => viewModel.disposeResource(layoutViewModel),
      builder: (context, viewModel, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: [errorColor, primaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20.0, top: 40, bottom: 30),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/formIcon.svg",
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                    child: Text(
                                      "NEW APPLICATION",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: s,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.5,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _menuButton("Card Page", viewModel, ApplicationFormState.cardPage),
                                  _menuButton("Customer ID", viewModel, ApplicationFormState.customerId),
                                  _menuButton("Customer Details", viewModel, ApplicationFormState.customerDetails),
                                  _menuButton("Card Selection", viewModel, ApplicationFormState.cardSelection),
                                  _menuButton("Documents", viewModel, ApplicationFormState.documents),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.applicationFormState == ApplicationFormState.cardPage
                                    ? "Card Page"
                                    : viewModel.applicationFormState == ApplicationFormState.customerId
                                    ? "Customer ID"
                                    : viewModel.applicationFormState == ApplicationFormState.customerDetails
                                    ? "Customer Details"
                                    : viewModel.applicationFormState == ApplicationFormState.cardSelection
                                    ? "Card Selection"
                                    : "Documents",
                                style: const TextStyle(
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
                          child: viewModel.applicationFormPage(cardData: cardData),
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
  }


  Widget _menuButton(String label, ApplicationFormViewModel viewModel, ApplicationFormState value) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: viewModel.applicationFormState == value
              ? Colors.white
              : Colors.transparent,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100), topLeft: Radius.circular(100)),
        ),
        child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: m,
            color: viewModel.applicationFormState == value
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }

}

