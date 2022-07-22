import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/customer_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class AccountDetailsView extends ViewModelWidget<CustomerProfileViewModel> {
  const AccountDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, CustomerProfileViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Account Details",
                style: TextStyle(
                    color: blackColorMono,
                    fontSize: xxl,
                    fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () {
                  // viewModel.changeLayoutViewIndex(LayoutViewIndex.dashboardView);
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
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: lightGreyColor,
                border: Border.all(color: primaryGrey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      color: Colors.white,
                    ),
                    child: const Text("Account 1", style: TextStyle(color: blackColorMono, fontSize: l),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: viewModel.ibanTEC,
                          style: const TextStyle(
                              color: blackColorMono),
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "IBAN ",
                            labelStyle: TextStyle(color: darkGreyColor),
                            disabledBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: borderGreyColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.accountType,
                          style: const TextStyle(
                              color: blackColorMono),
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Account Type",
                            labelStyle: TextStyle(color: darkGreyColor),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: borderGreyColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.statusTEC,
                          style: const TextStyle(
                              color: blackColorMono),
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Status",
                            labelStyle: TextStyle(color: darkGreyColor),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: borderGreyColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.accountBalance,
                          style: const TextStyle(
                              color: blackColorMono),
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Account Balance",
                            labelStyle: TextStyle(color: darkGreyColor),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: borderGreyColor),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
