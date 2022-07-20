import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/customer_profile/account_details.dart';
import 'package:loan_application_system/view/customer_profile/product_details.dart';
import 'package:loan_application_system/view_model/customer_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomerProfileView extends StatelessWidget {
  const CustomerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerProfileViewModel>.reactive(
      viewModelBuilder: () => CustomerProfileViewModel(),
      onDispose: (viewModel) {
        viewModel.disposeResource();
      },
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
                            padding: const EdgeInsets.only(left: 20, right: 20.0, top: 40, bottom: 30),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/profileIcon.svg", color: Colors.white,),
                                const SizedBox(width: 10),
                                const Expanded(child: Text("CUSTOMER PROFILE", style: TextStyle(color: Colors.white, fontSize: s, fontWeight: FontWeight.w700, letterSpacing: 1.5,),)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _menuButton("Profile Details", CustomerProfileViewState.profile, viewModel),
                                  _menuButton("Account Details", CustomerProfileViewState.account, viewModel),
                                  _menuButton("Product Details", CustomerProfileViewState.product, viewModel),
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
                    child: viewModel.customerProfileViewState == CustomerProfileViewState.profile
                        ? _profileDetailWidget(viewModel)
                        : viewModel.customerProfileViewState == CustomerProfileViewState.account
                          ? const AccountDetailsView()
                          : const ProductDetailsView()
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menuButton(String label, CustomerProfileViewState customerProfileViewState, CustomerProfileViewModel viewModel) {
    return InkWell(
      onTap: () {
        viewModel.changeState(customerProfileViewState);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: customerProfileViewState == viewModel.customerProfileViewState
              ? Colors.white
              : Colors.transparent,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100), topLeft: Radius.circular(100)),
        ),
        child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: m,
            color: customerProfileViewState == viewModel.customerProfileViewState
                ? blackColorMono
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _profileDetailWidget(CustomerProfileViewModel viewModel) {
    return Builder(
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Profile Details",
                        style: TextStyle(
                            color: blackColorMono,
                            fontSize: xxl,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: viewModel.profileImagePath != null?errorColor:borderGreyColor))),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(viewModel.profileImagePath != null?errorColor:blackColorMono),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Edit",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w700),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.mode_edit_outline_outlined),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
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
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 30),

                        Container(
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
                                child: const Text("ID Details", style: TextStyle(color: blackColorMono, fontSize: l),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Profile Picture",
                                      style: TextStyle(
                                        color: secondaryDarkGrey,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: viewModel.profileImagePath == null
                                            ? Container(
                                                height: 70,
                                                width: 70,
                                                color: secondaryDarkGrey,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "PD",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: xxl,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              )
                                            : Image.file(File(viewModel.profileImagePath!), fit: BoxFit.cover, height: 70, width: 70,),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            viewModel.pickAndUpload(context);
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                side: BorderSide(color: viewModel.profileImagePath != null?errorColor:borderGreyColor))),
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            foregroundColor: MaterialStateProperty.all(viewModel.profileImagePath != null?errorColor:blackColorMono),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                viewModel.profileImagePath != null?"Remove Picture":"Upload Picture",
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                              const SizedBox(width: 10),
                                              viewModel.profileImagePath != null
                                                  ? const Icon(Icons.delete_outlined)
                                                  : SvgPicture.asset("assets/uploadIcon.svg"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: viewModel.fullNameTEC,
                                      enabled: false,
                                      style: const TextStyle(
                                          color: blackColorMono),
                                      decoration: const InputDecoration(
                                        labelText: "Full Name",
                                        labelStyle: TextStyle(color: darkGreyColor),
                                        disabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: borderGreyColor),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.nationalityTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "Nationality",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.birthDateTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "Date of Birth",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: viewModel.idTypeTEC,
                                      style: const TextStyle(
                                          color: blackColorMono),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        labelText: "ID Type",
                                        labelStyle: TextStyle(color: darkGreyColor),
                                        disabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: borderGreyColor),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.idNumberTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "ID Number",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.expiryDateTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "ID Expiry",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Front ID",style: TextStyle(color: darkGreyColor),),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.asset("assets/frontId.png"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Back ID", style: TextStyle(color: darkGreyColor),),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.asset("assets/backId.png"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
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
                                child: const Text("Contact Details", style: TextStyle(color: blackColorMono, fontSize: l),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.mobileNumberTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "Mobile Number",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.emailTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "Email",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
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
                                child: const Text("Employment Details", style: TextStyle(color: blackColorMono, fontSize: l),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.employmentStatusTEC,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "Employment Status",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: TextField(
                                            controller: viewModel.employmentName,
                                            style: const TextStyle(
                                                color: blackColorMono),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: "Employment Name",
                                              labelStyle: TextStyle(color: darkGreyColor),
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: borderGreyColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    TextField(
                                      controller: viewModel.monthlySalary,
                                      style: const TextStyle(
                                          color: blackColorMono),
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        labelText: "Monthly Salary",
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

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
