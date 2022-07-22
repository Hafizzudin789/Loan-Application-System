import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/upload_document_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:loan_application_system/view_model/customer_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class CreateCustomerProfileView extends StatelessWidget {
  const CreateCustomerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerProfileViewModel>.reactive(
      viewModelBuilder: () => CustomerProfileViewModel(),
      onDispose: (viewModel) {
        viewModel.disposeResource();
      },
      builder: (context, viewModel, _) {
        return ViewModelBuilder<ApplicationFormViewModel>.reactive(
          viewModelBuilder: () => ApplicationFormViewModel(),
          builder: (context, applicationViewModel, _) {
            return Scaffold(
              // resizeToAvoidBottomInset: false,
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
                                      "assets/profileIcon.svg",
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                        child: Text(
                                          "CREATE CUSTOMER PROFILE",
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      _menuButton(
                                          "Profile Details",
                                          CustomerProfileViewState.profile,
                                          viewModel),
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
                              Expanded(child: _profileDetailWidget(viewModel, applicationViewModel)),
                              const Divider(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: applicationViewModel.frontIdImagePath != null && applicationViewModel.backIdImagePath != null
                                        && applicationViewModel.dropdownEmployeeValue != null
                                        && viewModel.mobileNumberTEC.text.isNotEmpty && viewModel.emailTEC.text.isNotEmpty
                                        && viewModel.employmentName.text.isNotEmpty
                                        && viewModel.monthlySalary.text.isNotEmpty?() {
                                      _confirmDetailsPopUp(context, applicationViewModel, viewModel);
                                    }: null,
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          side: BorderSide(color: viewModel.profileImagePath != null?errorColor:borderGreyColor))),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25)),
                                      foregroundColor: MaterialStateProperty.all(
                                        applicationViewModel.frontIdImagePath != null && applicationViewModel.backIdImagePath != null
                                            && applicationViewModel.dropdownEmployeeValue != null
                                          && viewModel.mobileNumberTEC.text.isNotEmpty && viewModel.emailTEC.text.isNotEmpty
                                            && viewModel.employmentName.text.isNotEmpty
                                            && viewModel.monthlySalary.text.isNotEmpty
                                            ? primaryColor
                                            : idleGreyColor,
                                      ),
                                    ),
                                    child: const Text(
                                      "Create",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w700),
                                    ),
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
            );
          },
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


  Widget _profileDetailWidget(CustomerProfileViewModel viewModel, ApplicationFormViewModel applicationFormViewModel) {
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
                                              : Image.file(
                                                  File(viewModel.profileImagePath!),
                                                  fit: BoxFit.cover,
                                                  height: 70,
                                                  width: 70,
                                                ),
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
                                            foregroundColor: MaterialStateProperty.all(
                                             viewModel.profileImagePath != null
                                                  ? errorColor
                                                  : blackColorMono,
                                            ),
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
                                                  : SvgPicture.asset(
                                                      "assets/uploadIcon.svg",
                                                      color: blackColorMono,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    UploadDocumentWidget(label: "Please scan your New ID", viewModel: applicationFormViewModel,)
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
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Mobile Number",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              TextField(
                                                controller: viewModel.mobileNumberTEC,
                                                keyboardType: TextInputType.text,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700),
                                                onChanged: (value) {
                                                  viewModel.updateUI();
                                                },
                                                decoration: const InputDecoration(
                                                  isDense: true,
                                                  hintText: "Enter mobile address",
                                                  hintStyle: TextStyle(
                                                    color: greyColor,
                                                    fontSize: m,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  disabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: borderGreyColor),
                                                  ),
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
                                              Text(
                                                "Email",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              TextField(
                                                controller: viewModel.emailTEC,
                                                keyboardType: TextInputType.text,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700),
                                                onChanged: (value) {
                                                  viewModel.updateUI();
                                                },
                                                decoration: const InputDecoration(
                                                  isDense: true,
                                                  hintText: "Enter email address",
                                                  hintStyle: TextStyle(
                                                    color: greyColor,
                                                    fontSize: m,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  disabledBorder:
                                                      UnderlineInputBorder(
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
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Employment status", style: TextStyle(color: darkGreyColor),),
                                              PopupMenuButton<String>(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                offset: const Offset(0, 40),
                                                itemBuilder: (context) => applicationFormViewModel.dropdownEmployeeTypeList.map(
                                                      (e) => PopupMenuItem<String>(
                                                        value: e,
                                                        child: Text(e),
                                                      ),
                                                ).toList(),
                                                onSelected: (String value) {
                                                  applicationFormViewModel.selectStatus(value);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          applicationFormViewModel.dropdownEmployeeValue??"",
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
                                              Text("Employment Name", style: Theme.of(context).textTheme.bodyText1,),
                                              TextField(
                                                controller: viewModel.employmentName,
                                                keyboardType: TextInputType.text,
                                                style: const TextStyle(fontWeight: FontWeight.w700),
                                                onChanged: (value){
                                                  viewModel.updateUI();
                                                },
                                                decoration: const InputDecoration(
                                                  isDense: true,
                                                  hintText: "Enter employment name",
                                                  hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
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
                                    const SizedBox(height: 20),
                                    // TextField(
                                    //   controller: viewModel.monthlySalary,
                                    //   style: const TextStyle(
                                    //       color: blackColorMono),
                                    //   decoration: const InputDecoration(
                                    //     labelText: "Monthly Salary",
                                    //     labelStyle: TextStyle(color: darkGreyColor),
                                    //     disabledBorder: UnderlineInputBorder(
                                    //       borderSide: BorderSide(
                                    //           color: borderGreyColor),
                                    //     ),
                                    //   ),
                                    //   onChanged: (value) {
                                    //     viewModel.updateUI();
                                    //   },
                                    // ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Monthly Salary", style: Theme.of(context).textTheme.bodyText1,),
                                        TextField(
                                          controller: viewModel.monthlySalary,
                                          keyboardType: TextInputType.text,
                                          style: const TextStyle(fontWeight: FontWeight.w700),
                                          onChanged: (value){
                                            viewModel.updateUI();
                                          },
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            hintText: "Monthly Salary",
                                            hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                                            disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: borderGreyColor),
                                            ),
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

  void _confirmDetailsPopUp(BuildContext context, ApplicationFormViewModel applicationFormViewModel, CustomerProfileViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 20),
                      child: Row(
                        children: [
                          Expanded(child: Text("Confirm the details below before proceed", style: Theme.of(context).textTheme.headline2,)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: SvgPicture.asset("assets/closeIcon.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Applicant Name", style: Theme.of(context).textTheme.bodyText1,),
                              TextField(
                                controller: applicationFormViewModel.applicantNameTEC,
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: "Enter applicant name",
                                  hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.04),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Date of Birth", style: Theme.of(context).textTheme.bodyText1,),
                                    TextField(
                                      readOnly: true,
                                      controller: applicationFormViewModel.birthDateTEC,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                      onChanged: (value){},
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: "Enter date of birth",
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
                                    Text("Nationality", style: Theme.of(context).textTheme.bodyText1,),
                                    TextField(
                                      readOnly: true,
                                      controller: applicationFormViewModel.nationalityTEC,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                      onChanged: (value){},
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: "Enter nationality",
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

                          SizedBox(height: MediaQuery.of(context).size.height*0.04),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID Type", style: Theme.of(context).textTheme.bodyText1,),
                                    TextField(
                                      readOnly: true,
                                      controller: applicationFormViewModel.idTypeTEC,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                      onChanged: (value){},
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: "Enter id type",
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
                                    Text("ID Number", style: Theme.of(context).textTheme.bodyText1,),
                                    TextField(
                                      readOnly: true,
                                      controller: applicationFormViewModel.idNumberTEC,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                      onChanged: (value){},
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        hintText: "Enter id number",
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

                          SizedBox(height: MediaQuery.of(context).size.height*0.04),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID Expiry", style: Theme.of(context).textTheme.bodyText1,),
                              TextField(
                                readOnly: true,
                                controller: applicationFormViewModel.idExpiryDateTEC,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                                onChanged: (value){},
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: "Enter id expiry date",
                                  hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*0.04),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                child: const Text("Scan Again", style: TextStyle(fontWeight: FontWeight.w700),),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  locator<NavigationService>().goBack();
                                  _showSuccessDialog(context);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),)),
                                  backgroundColor: MaterialStateProperty.all(applicationFormViewModel.detailsIsConfirmed()?successColor:idleGreyColor,),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                ),
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
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
            ),
          ),
        );
      },
    );
  }

  _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: SvgPicture.asset("assets/closeIcon.svg"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightGreyColor,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: successColor,
                              ),
                              child: const Icon(Icons.done, color: Colors.white,),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text("Profile Details is successfully created", style: TextStyle(fontSize: xl, fontWeight: FontWeight.w900, color: blackColorMono),),
                          const SizedBox(height: 20),
                          Container(
                            color: lightGreyColor,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Customer Name", style: TextStyle(fontSize: s, fontWeight: FontWeight.w500, color: darkGreyColor),),
                                SizedBox(height: 2),
                                Text("Faisal Saeed Ahmed Mohamed Qamar Alzaman", style: TextStyle(fontSize: m, fontWeight: FontWeight.w900, color: blackColorMono),),
                                SizedBox(height: 15),
                                Text("Ref Number",  style: TextStyle(fontSize: s, fontWeight: FontWeight.w500, color: darkGreyColor),),
                                SizedBox(height: 2),
                                Text("300002239488", style: TextStyle(fontSize: m, fontWeight: FontWeight.w900, color: blackColorMono),),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: const BorderSide(color: borderGreyColor, width: 1))),
                              backgroundColor: MaterialStateProperty.all(Colors.white,),
                              foregroundColor: MaterialStateProperty.all(primaryColor),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30)),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
