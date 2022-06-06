import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/widgets/selected_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../utils/font_size.dart';

class CustomerDetailsPage extends ViewModelWidget<ApplicationFormViewModel> {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ApplicationFormViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Customer Details",
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
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
                    ),
                    Expanded(
                      child: TextField(
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: viewModel.employmentStatusTEC,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                        onChanged: (value){},
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Select employment status",
                          hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
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
                    ),
                  ],
                ),
                TextField(
                  controller: viewModel.monthlySalaryTEC,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                  onChanged: (value){},
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Monthly Salary",
                    hintStyle: TextStyle(color: greyColor, fontSize: m, fontWeight: FontWeight.w700,),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor, width: 1),),
                  ),
                ),
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
                        viewModel.changeApplicationFormState(ApplicationFormState.cardSelection);
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
