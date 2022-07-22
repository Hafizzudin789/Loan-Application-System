import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/customer_list_view/account_details.dart';
import 'package:loan_application_system/view/customer_list_view/product_details.dart';
import 'package:loan_application_system/view/widgets/upload_document_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:loan_application_system/view_model/customer_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomerProfileView extends StatelessWidget {
  final String customerName;
  const CustomerProfileView({Key? key, required this.customerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerProfileViewModel>.reactive(
      viewModelBuilder: () => CustomerProfileViewModel(),
      onModelReady: (viewModel)=>viewModel.initialize(customerName),
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
                                      "CUSTOMER PROFILE",
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
                                      _menuButton(
                                          "Account Details",
                                          CustomerProfileViewState.account,
                                          viewModel),
                                      _menuButton(
                                          "Product Details",
                                          CustomerProfileViewState.product,
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
                          child: viewModel.customerProfileViewState ==
                                  CustomerProfileViewState.profile
                              ? _profileDetailWidget(viewModel, applicationViewModel)
                              : viewModel.customerProfileViewState ==
                                      CustomerProfileViewState.account
                                  ? const AccountDetailsView()
                                  : const ProductDetailsView()),
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
                    viewModel.isEditable
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  viewModel.changeEditCustomerProfileDataBool();
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          side: const BorderSide(color: borderGreyColor))),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25, vertical: 5)),
                                  foregroundColor: MaterialStateProperty.all(blackColorMono),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  if(viewModel.isCustomerIdExpired(customerName)){
                                    if(applicationFormViewModel.frontIdImagePath!=null && applicationFormViewModel.backIdImagePath!=null){
                                      _confirmDetailsPopUp(context, applicationFormViewModel, viewModel);
                                      // viewModel.changeEditCustomerProfileDataBool();
                                    }
                                  } else {
                                    _showSuccessDialog(context, viewModel);
                                    // viewModel.changeEditCustomerProfileDataBool();
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                         )),
                                  backgroundColor: MaterialStateProperty.all(primaryColor),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                ),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Save",
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 15),
                                    Icon(Icons.save_outlined),
                                  ],
                                ),
                              )
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              viewModel.changeEditCustomerProfileDataBool();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                          color: viewModel.profileImagePath != null
                                              ? errorColor
                                              : borderGreyColor))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor: MaterialStateProperty.all(
                                  viewModel.profileImagePath != null
                                      ? errorColor
                                      : blackColorMono),
                            ),
                            child: Row(
                              children: const [
                                Text(
                                  "Edit",
                                  style: TextStyle(fontWeight: FontWeight.w700),
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
                                          onPressed: !viewModel.isEditable ? null : () {
                                            viewModel.pickAndUpload(context);
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                side: BorderSide(color: viewModel.profileImagePath != null?errorColor:borderGreyColor))),
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            foregroundColor: MaterialStateProperty.all(
                                              !viewModel.isEditable
                                                  ? idleGreyColor
                                                  : viewModel.profileImagePath != null
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
                                                      color: !viewModel.isEditable
                                                          ? idleGreyColor
                                                          : blackColorMono,
                                                    ),
                                        ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    viewModel.isCustomerIdExpired(customerName)
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: const [
                                              Text(
                                                "Customer ID is expired, New application required customer to update ID details.",
                                                style: TextStyle(
                                                  color: errorColor,
                                                  fontSize: s,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          )
                                        : const SizedBox(),
                                    TextField(
                                      controller: viewModel.fullNameTEC,
                                      enabled: false,
                                      style: const TextStyle(
                                          color: blackColorMono),
                                      decoration: InputDecoration(
                                        labelText: "Full Name",
                                        labelStyle: const TextStyle(color: darkGreyColor),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                                  ? errorColor
                                                  : borderGreyColor),
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
                                            decoration: InputDecoration(
                                              labelText: "Nationality",
                                              labelStyle: const TextStyle(color: darkGreyColor),
                                              disabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                                        ? errorColor
                                                        : borderGreyColor),
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
                                            decoration: InputDecoration(
                                              labelText: "Date of Birth",
                                              labelStyle: const TextStyle(color: darkGreyColor),
                                              disabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                                        ? errorColor
                                                        : borderGreyColor),
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
                                      decoration: InputDecoration(
                                        labelText: "ID Type",
                                        labelStyle: const TextStyle(color: darkGreyColor),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                                  ? errorColor
                                                  : borderGreyColor),
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
                                            decoration: InputDecoration(
                                              labelText: "ID Number",
                                              labelStyle: const TextStyle(color: darkGreyColor),
                                              disabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                                        ? errorColor
                                                        : borderGreyColor),
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
                                            decoration: InputDecoration(
                                              labelText: "ID Expiry",
                                              labelStyle: const TextStyle(color: darkGreyColor),
                                              disabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                                        ? errorColor
                                                        : borderGreyColor),
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
                                    ),
                                    viewModel.isEditable && viewModel.isCustomerIdExpired(customerName)
                                        ? Column(
                                            children: [
                                              const SizedBox(height: 50),
                                              UploadDocumentWidget(label: "Please scan your New ID", viewModel: applicationFormViewModel,)
                                            ],
                                          )
                                        : const SizedBox(),
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
                                            enabled: viewModel.isEditable,
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
                                            enabled: viewModel.isEditable,
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
                                            enabled: viewModel.isEditable,
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
                                            enabled: viewModel.isEditable,
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
                                      enabled: viewModel.isEditable,
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

  _showSuccessDialog(BuildContext context, CustomerProfileViewModel viewModel) {
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
                          const Text("Profile Details is successfully updated", style: TextStyle(fontSize: xl, fontWeight: FontWeight.w900, color: blackColorMono),),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              viewModel.changeEditCustomerProfileDataBool();
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
                                  _showSuccessDialog(context, viewModel);
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
}


