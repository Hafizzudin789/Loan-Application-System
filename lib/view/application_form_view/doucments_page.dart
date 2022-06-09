import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:stacked/stacked.dart';

class DocumentsPage extends ViewModelWidget<ApplicationFormViewModel> {
  const DocumentsPage({Key? key}) : super(key: key);

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
                "Documents",
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  _paySlipCard(viewModel),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  _bankStatementCard(viewModel),
                ],
              ),
            ),
          ),
        ),
        _progressBar(viewModel)
      ],
    );
  }

  Widget _paySlipCard(ApplicationFormViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderGreyColor),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: lightGreyColor,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(-2, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.white,
                ),
                child: Text(
                  "Last Payslip from employer",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: viewModel.paySlipDocsPath == null
                          ? ElevatedButton(
                              onPressed: () {
                                viewModel.setPaySlipDocs("paySlipPdfPath");
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: const BorderSide(color: borderGreyColor),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(primaryColor),
                                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Upload Document",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SvgPicture.asset("assets/uploadIcon.svg", color: primaryColor,)
                                ],
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25),
                                        side: const BorderSide(
                                            color: borderGreyColor))),
                                backgroundColor:
                                MaterialStateProperty.all(
                                    Colors.white),
                                foregroundColor:
                                MaterialStateProperty.all(
                                    blackColorMono),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Expanded(
                                    child: Text(
                                      "Document.pdf",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: blackColorMono,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: blackColorMono,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                    ),

                    const SizedBox(width: 10),

                    viewModel.paySlipDocsPath == null
                        ? Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.openCamera(true);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(blackColorMono),
                                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Expanded(
                                    child:  Text(
                                      "Use Camera",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w700,
                                          color: primaryColor),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.photo_camera_outlined,
                                    color: primaryColor,
                                    size: 19,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              viewModel.setPaySlipDocs(null);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: borderGreyColor),
                                boxShadow: const [
                                  BoxShadow(
                                      color: idleGreyColor,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(-0.5, 2)),
                                ],
                              ),
                              child: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 20),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _bankStatementCard(ApplicationFormViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderGreyColor),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: lightGreyColor,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(-2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.white,
                ),
                child: Text(
                  "Latest 3 months of bank statement",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: viewModel.bankStatementDocsPath == null
                          ? ElevatedButton(
                              onPressed: () {
                                viewModel.setBankStatementDocs("setBankStatementDocsPath");
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: const BorderSide(color: borderGreyColor),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(primaryColor),
                                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Upload Document",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SvgPicture.asset("assets/uploadIcon.svg", color: primaryColor,)
                                ],
                              ),
                            )
                          : ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(25),
                                  side: const BorderSide(
                                      color: borderGreyColor))),
                          backgroundColor:
                          MaterialStateProperty.all(
                              Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all(
                              blackColorMono),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Expanded(
                              child: Text(
                                "Document.pdf",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: blackColorMono,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: blackColorMono,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    viewModel.bankStatementDocsPath == null
                        ? Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.openCamera(false);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                foregroundColor: MaterialStateProperty.all(blackColorMono),
                                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Expanded(
                                    child:  Text(
                                      "Use Camera",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w700,
                                          color: primaryColor),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.photo_camera_outlined,
                                    color: primaryColor,
                                    size: 19,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              viewModel.setBankStatementDocs(null);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: borderGreyColor),
                                boxShadow: const [
                                  BoxShadow(
                                      color: idleGreyColor,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(-0.5, 2)),
                                ],
                              ),
                              child: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 20),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
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
                        viewModel.changeApplicationFormState(ApplicationFormState.cardSelection);
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
                      onPressed: viewModel.paySlipDocsPath != null && viewModel.bankStatementDocsPath != null
                          ? () {
                        locator<NavigationService>().goBack();
                        _showSuccessDialog(context);
                      }
                          : null,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),)),
                        backgroundColor: MaterialStateProperty.all( viewModel.paySlipDocsPath != null && viewModel.bankStatementDocsPath != null
                            ? successColor
                            : idleGreyColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 20)),
                      ),
                      child: const Text(
                        "Submit Application",
                        style: TextStyle(fontWeight: FontWeight.w700),
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

  _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
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
                            padding: const EdgeInsets.all(15),
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
                              child: const Icon(Icons.done, color: Colors.white, size: 20,),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          const Text(
                            "Congrats! Faisal Saeed application for\nDigibanc Cash Back Platinum MasterCard is approve!",
                            style: TextStyle(
                              color: blackColorMono,
                              fontSize: xl,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Expanded(child: Text("The card order is Placed to be delivered via Aramex", style: TextStyle(color: blackColorMono, fontWeight: FontWeight.w700),)),
                              Text("View Tracker", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700),),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.035),

                          Container(
                            padding: const EdgeInsets.all(20),
                            color: lightGreyColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _labelValueWidget("Applicant Name", "Faisal Saeed Ahmed Mohamed Qamar Alzaman"),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Expanded(child: _labelValueWidget("Product", "Islamic Credit Card")),
                                    Expanded(child: _labelValueWidget("Card Type", "Platinum")),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                _labelValueWidget("Facility", "Digibanc Cash Back Platinum MasterCard"),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Expanded(child: _labelValueWidget("Applicant Email", "dorwart@mail.com")),
                                    Expanded(child: _labelValueWidget("Rate", "3.6 %")),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                _labelValueWidget("Status", "Card Order Placed"),
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
                          const SizedBox(height: 10),
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

  Widget _labelValueWidget(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: darkGreyColor, fontSize: s),),
        const SizedBox(height: 2),
        label == "Status"
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: orangeColor,
              ),
              child: Text(value, style: const TextStyle(color: blackColorMono, fontSize: s-1, fontWeight: FontWeight.w700),),
            )
          : Text(value, style: const TextStyle(color: blackColorMono, fontSize: m, fontWeight: FontWeight.w700),),
      ],
    );
  }
}
