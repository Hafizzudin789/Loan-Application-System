import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/services/routing_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/view_model/application_form_view_model.dart';

class UploadDocumentWidget extends StatelessWidget {
  final String label;
  final ApplicationFormViewModel viewModel;
  const UploadDocumentWidget({Key? key, required this.label, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Theme.of(context).textTheme.headline2,),
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
                          if(viewModel.frontIdImagePath==null) {
                            Timer? frontIdScanTimer;
                            frontIdScanTimer = Timer(const Duration(seconds: 4), () {
                              viewModel.setFrontIdImagePath("assets/frontId.png");
                              locator<NavigationService>().goBackGlobal();
                            });
                            locator<NavigationService>().navigateToAndBackGlobal(scanIdView, arguments: ["Front ID", frontIdScanTimer]);
                          }
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
                                ? const Icon(Icons.remove_red_eye_outlined, size: 20,)
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
                                  border: Border.all(color: borderGreyColor),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: idleGreyColor,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(-0.5, 2)),
                                  ],
                                ),
                                child: const Icon(Icons.delete_outline_rounded,
                                    size: 20),
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
                          if(viewModel.backIdImagePath==null) {
                            Timer? backIdScanTimer;
                            backIdScanTimer = Timer(const Duration(seconds: 4), () {
                              viewModel.setBackIdImagePath("assets/backId.png");
                              locator<NavigationService>().goBackGlobal();
                            });
                            locator<NavigationService>().navigateToAndBackGlobal(scanIdView, arguments: ["Back ID", backIdScanTimer]);
                          }
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
                                ? const Icon(Icons.remove_red_eye_outlined, size: 20,)
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
                                  border: Border.all(color: borderGreyColor),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: idleGreyColor,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(-0.5, 2)),
                                  ],
                                ),
                                child: const Icon(Icons.delete_outline_rounded,
                                    size: 20),
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
    );
  }
}
