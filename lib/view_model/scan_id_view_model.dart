import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:loan_application_system/services/toast_message.dart';
import 'package:stacked/stacked.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanIdViewModel extends BaseViewModel with WidgetsBindingObserver{

  CameraController? cameraController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        onNewCameraSelected(cameraController!.description);
      }
    }
  }

  late List<CameraDescription> _cameras;
  int _selectedCamera = 0;

  initializeCamera() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();

    if((statuses[Permission.camera] == PermissionStatus.permanentlyDenied) ||(statuses[Permission.camera] == PermissionStatus.denied)
        || (statuses[Permission.camera] == PermissionStatus.restricted)) {
      openAppSettings();
    }

    if((statuses[Permission.camera] == PermissionStatus.granted)) {
      WidgetsBinding.instance.addObserver(this);
      try {
        WidgetsFlutterBinding.ensureInitialized();
        _cameras = await availableCameras();
        //default front camera if exists
        if(_cameras.length>1) {
          _selectedCamera = 0;
        }
      } on CameraException catch (e) {
        toastMessage(message: e.toString());
        return;
      }
      await onNewCameraSelected(_cameras[_selectedCamera]);
    }
  }

  onNewCameraSelected(CameraDescription cameraDescription) async{
    final previousCameraController = cameraController;

    // instantiating the camera controller
    final CameraController controller = CameraController(
      cameraDescription, ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    //disposing the previous controller
    await previousCameraController?.dispose();

    //replace with the new controller
    cameraController = controller;

    // initialize controller
    try {
      await cameraController!.initialize();
    } on CameraException catch (e) {
      toastMessage(message: e.toString());
    }
    notifyListeners();
  }

  Timer? frontIdScanTimer;
  Timer? backIdScanTimer;

  disposeResource() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    frontIdScanTimer?.cancel();
    backIdScanTimer?.cancel();
  }
}