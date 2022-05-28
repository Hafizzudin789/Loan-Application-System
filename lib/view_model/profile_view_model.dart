import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';

enum ProfileViewState{
  profile,
  security;
}

class ProfileViewModel extends BaseViewModel {
  final firstNameTEC = TextEditingController(text: "Phillip");
  final lastNameTEC = TextEditingController(text: "Dias");
  final emailTEC = TextEditingController(text: "dias@test.com");
  final birthDateTEC = TextEditingController(text: "14 / 02 / 89");
  final statusTEC = TextEditingController(text: "Active");
  final joinDateTEC = TextEditingController(text: "21 Sep 21");


  ProfileViewState profileViewState = ProfileViewState.profile;
  changeState(ProfileViewState value) {
    profileViewState = value;
    notifyListeners();
  }


  final formKey = GlobalKey<FormState>();
  final reenterFormKey = GlobalKey<FormState>();

  final passwordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();

  final reenterPasswordTEC = TextEditingController();

  updateState() {
    notifyListeners();
  }

  String? profileImagePath;
  pickAndUpload() async{
    if(profileImagePath != null) {
      profileImagePath = null;
      notifyListeners();
      return;
    }
    ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if(imageFile!=null) {
      profileImagePath = imageFile.path;
      notifyListeners();
    }
  }

  disposeResource() {
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    emailTEC.dispose();
    birthDateTEC.dispose();
    statusTEC.dispose();
    joinDateTEC.dispose();

    passwordTEC.dispose();
    confirmPasswordTEC.dispose();

    reenterPasswordTEC.dispose();
  }
}