import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/view_model/scan_id_view_model.dart';
import 'package:stacked/stacked.dart';


class ScanIdView extends StatelessWidget {
  final String textValue;
  final Timer timer;
  const ScanIdView({Key? key, required this.textValue, required this.timer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanIdViewModel>.reactive(
      viewModelBuilder: () => ScanIdViewModel(),
      onModelReady: (viewModel)=>viewModel.initializeCamera(),
      onDispose: (viewModel) {
        viewModel.disposeResource();
        timer.cancel();
      },
      builder: (context, viewModel, _) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              viewModel.cameraController!=null && viewModel.cameraController!.value.isInitialized
                  ? Transform.scale(
                scale: (screenWidth / viewModel.cameraController!.value.previewSize!.width) > (screenHeight / viewModel.cameraController!.value.previewSize!.height)
                    ? (screenWidth / viewModel.cameraController!.value.previewSize!.width) + 0.25
                    : (screenHeight / viewModel.cameraController!.value.previewSize!.height) + 0.25,
                child: Center(
                  child: CameraPreview(viewModel.cameraController!),
                ),
              )
                  : Center(child: Container(color: blackColorMono,),),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>().goBackGlobal();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SvgPicture.asset(
                      "assets/closeIcon.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 380,
                      width: 600,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XFFF5F5F5), width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("Scanning...", style: TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(height: 20),
                    Text(textValue, style: const TextStyle(color: Colors.white),),
                    const Text("ID will be scanned automatically when\nplaced within the frame", textAlign: TextAlign.center,  style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

