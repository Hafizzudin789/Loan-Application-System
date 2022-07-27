import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/upload_document_widget.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomerIdPage extends ViewModelWidget<ApplicationFormViewModel> {
  const CustomerIdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ApplicationFormViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Center(
              child: SingleChildScrollView(
                child: UploadDocumentWidget(
                    label: "Please scan your ID", viewModel: viewModel),
              ),
            ),
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
                        viewModel.changeApplicationFormState(ApplicationFormState.cardPage);
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
                      onPressed: viewModel.frontIdImagePath!=null && viewModel.backIdImagePath!=null ? () {
                        _confirmDetailsPopUp(context, viewModel);
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
                        style: TextStyle(fontWeight: FontWeight.w700, color: viewModel.frontIdImagePath!=null && viewModel.backIdImagePath!=null ? primaryColor:idleGreyColor),
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

  void _confirmDetailsPopUp(BuildContext context, ApplicationFormViewModel viewModel) {
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
                                controller: viewModel.applicantNameTEC,
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
                                      controller: viewModel.birthDateTEC,
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
                                      controller: viewModel.nationalityTEC,
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
                                      controller: viewModel.idTypeTEC,
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
                                      controller: viewModel.idNumberTEC,
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
                                controller: viewModel.idExpiryDateTEC,
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
                                onPressed: viewModel.detailsIsConfirmed() ? () {
                                  Navigator.pop(context);
                                  viewModel.changeApplicationFormState(ApplicationFormState.customerDetails);
                                }: null,
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),)),
                                  backgroundColor: MaterialStateProperty.all(viewModel.detailsIsConfirmed()?successColor:idleGreyColor,),
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
