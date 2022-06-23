import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/widgets/selected_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../utils/font_size.dart';

class CustomerDetailsPage extends ViewModelWidget<ApplicationFormViewModel> {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ApplicationFormViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mobile Number", style: Theme.of(context).textTheme.bodyText1,),
                          TextField(
                            controller: viewModel.phoneNumberTEC,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                            onChanged: (value){},
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Enter mobile number",
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
                          Text("Email Address", style: Theme.of(context).textTheme.bodyText1,),
                          TextField(
                            controller: viewModel.emailTEC,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                            onChanged: (value){},
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Enter email address",
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
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employment status", style: Theme.of(context).textTheme.bodyText1,),
                          // DropdownButton<String>(
                          //   value: viewModel.dropdownEmployeeValue,
                          //   hint: const Text("Select employment status", style: TextStyle(color: greyColor, fontSize: m+1),),
                          //   style: const TextStyle(fontWeight: FontWeight.w500, color: blackColorMono, fontSize: l),
                          //   isDense: true,
                          //   underline: const SizedBox(),
                          //   isExpanded: true,
                          //   icon: const Icon(Icons.keyboard_arrow_down, color: blackColorMono,),
                          //   items: viewModel.dropdownEmployeeTypeList.map((String items) {
                          //     return DropdownMenuItem(
                          //       value: items,
                          //       child: Text(items),
                          //     );
                          //   }).toList(),
                          //   onChanged: (String? newValue) {
                          //     viewModel.selectStatus(newValue);
                          //   },
                          // ),

                          PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            offset: const Offset(0, 40),
                            itemBuilder: (context) => viewModel.dropdownEmployeeTypeList.map(
                                  (e) => PopupMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  ).toList(),
                            onSelected: (String value) {
                              viewModel.selectStatus(value);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      viewModel.dropdownEmployeeValue??"",
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
                      )
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Employment Name", style: Theme.of(context).textTheme.bodyText1,),
                          TextField(
                            controller: viewModel.companyTEC,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                            onChanged: (value){},
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Enter employment name",
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
                const SizedBox(height: 30),
                Text("Monthly Salary", style: Theme.of(context).textTheme.bodyText1,),
                MonthlySalaryTextField(viewModel: viewModel),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  viewModel.agreeToTerms();
                },
                child: SelectedWidget(isSelected: viewModel.agreedToTerms),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Text("I hereby acknowledge I have read and agree to the Terms & Conditions for the "
                    "Credit Card and Credit Bureau authorisations outlined by the bank.", style: TextStyle(color: darkGreyColor, fontSize: s-1),),
              ),
            ],
          ),
        ),
        _progressBar(viewModel),
      ],
    );
  }


  Widget _progressBar(ApplicationFormViewModel viewModel) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.changeApplicationFormState(ApplicationFormState.customerId);
                      },
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
                        "Previous",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.customerDetailIsComplete() ? () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: SingleChildScrollView(
                                child: AlertDialog(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: SvgPicture.asset(
                                                  "assets/closeIcon.svg",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Image.asset("assets/mobile.png", scale: 1.2,),
                                          const SizedBox(height: 20),

                                          const Text("Almost there, enter 6-digit OTP", style: TextStyle(fontSize: xl, fontWeight: FontWeight.w600, color: blackColorMono),),
                                          const SizedBox(height: 5),
                                          const Text("Please enter the verification code sent to customer mobile", style: TextStyle(fontSize: m, fontWeight: FontWeight.w500, color: darkGreyColor),),
                                          Text(viewModel.phoneNumberTEC.text, style: const TextStyle(color: primaryColor, fontSize: m, fontWeight: FontWeight.w500,),),
                                          const SizedBox(height: 20),
                                          TextField(
                                            controller: viewModel.optTEC,
                                            obscureText: true,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6),],
                                            decoration: InputDecoration(
                                              hintText: "Enter 6-digit code",
                                              hintStyle: const TextStyle(color: greyColor, fontWeight: FontWeight.w600, fontSize: xl),
                                              border: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor,),),
                                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor,),),
                                              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor,),),
                                              errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: errorColor,),),
                                              errorText: viewModel.otpError,
                                              errorStyle: const TextStyle(color: errorColor),
                                            ),
                                          ),

                                          const SizedBox(height: 30),

                                          Row(
                                            children: [
                                              Expanded(child: Text(viewModel.optTEC.text.length==6 ?"Resend code":"Resend code 04:57", style: TextStyle(fontSize: m, fontWeight: FontWeight.w600, color: viewModel.optTEC.text.length==6 ?primaryColor:blackColorMono,),)),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(viewModel.optTEC.text.length==6 ? primaryColor: idleGreyColor),
                                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),),
                                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20),),
                                                ),
                                                onPressed: () {
                                                  if(viewModel.optTEC.text == Data.otpCode) {
                                                    Navigator.pop(context);
                                                    viewModel.changeApplicationFormState(ApplicationFormState.cardSelection);
                                                  } else {
                                                    setState((){
                                                      viewModel.otpError = "Incorrect verification code";
                                                    });
                                                  }
                                                },
                                                child: const Text("Verify", style: TextStyle(color: Colors.white, fontSize: m, fontWeight: FontWeight.w700),),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
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
                      child: Text(
                        "Next",
                        style: TextStyle(fontWeight: FontWeight.w700, color: viewModel.customerDetailIsComplete() ? primaryColor:idleGreyColor),
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
}

class MonthlySalaryTextField extends ViewModelWidget<LayoutViewModel> {
  final ApplicationFormViewModel viewModel;
  const MonthlySalaryTextField({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel layoutViewModel) {
    viewModel.monthlySalaryTEC.text = layoutViewModel.monthlyIncomeTEC.text;
    return TextField(
      controller: viewModel.monthlySalaryTEC,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontWeight: FontWeight.w700),
      onChanged: (value){},
      onTap: () {
        if(viewModel.monthlySalaryTEC.text.isEmpty) {
          viewModel.monthlySalaryTEC.text = "BHD ";
          viewModel.monthlySalaryTEC.selection = TextSelection.fromPosition(TextPosition(offset: viewModel.monthlySalaryTEC.text.length));
        }
      },
      decoration: const InputDecoration(
        isDense: true,
        hintText: "Monthly Salary",
        hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
      ),
    );
  }
}

