import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomerIdPage extends ViewModelWidget<ApplicationFormViewModel> {
  const CustomerIdPage({Key? key}) : super(key: key);

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
                "Customer ID",
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
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Please scan your ID", style: Theme.of(context).textTheme.headline2,),
                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderGreyColor),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: lightGreyColor, spreadRadius: 2, blurRadius: 5, offset: Offset(-2,2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                            color: Colors.white,
                          ),
                          child: Text("Front ID", style: Theme.of(context).textTheme.headline3,),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: lightGreyColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                          ),
                          child: Row(
                            children: [
                              viewModel.frontIdImagePath!=null
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(viewModel.frontIdImagePath!),
                                      ),
                                  )
                                  : const SizedBox(),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.setFrontIdImagePath("assets/frontId.png");
                                  },
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
                                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: viewModel.frontIdImagePath != null
                                            ? const Text("Front ID.pdf", style: TextStyle(
                                                fontWeight: FontWeight.w700,),)
                                            : const Text(
                                                "Use Camera",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: primaryColor),
                                              ),
                                      ),
                                      const SizedBox(width: 10),
                                      viewModel.frontIdImagePath != null
                                          ? const Icon(Icons.remove_red_eye_outlined)
                                          : const Icon(Icons.photo_camera_outlined, color: primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              viewModel.frontIdImagePath!=null
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          viewModel.setFrontIdImagePath(null);
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
                                              Icons.delete_outline_rounded),
                                        ),
                                      ),
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
                      border: Border.all(color: borderGreyColor),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: lightGreyColor, spreadRadius: 2, blurRadius: 5, offset: Offset(-2,2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                            color: Colors.white,
                          ),
                          child: Text("Back ID", style: Theme.of(context).textTheme.headline3,),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: lightGreyColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                          ),
                          child: Row(
                            children: [
                              viewModel.backIdImagePath!=null
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(viewModel.backIdImagePath!),
                                        ),
                                    )
                                  : const SizedBox(),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.setBackIdImagePath("assets/backId.png");
                                  },
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
                                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: viewModel.backIdImagePath != null
                                            ? const Text(
                                                "Back ID.pdf",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            : const Text(
                                                "Use Camera",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: primaryColor),
                                              ),
                                      ),
                                      const SizedBox(width: 10),
                                      viewModel.backIdImagePath != null
                                          ? const Icon(Icons.remove_red_eye_outlined)
                                          : const Icon(Icons.photo_camera_outlined, color: primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              viewModel.backIdImagePath!=null
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          viewModel.setBackIdImagePath(null);
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
                                              Icons.delete_outline_rounded),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
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
                        viewModel.changeApplicationFormState(ApplicationFormState.customerDetails);
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
}
