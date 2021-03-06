import 'package:flutter/material.dart';
import 'package:loan_application_system/services/toast_message.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';


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

  justChangeState(ProfileViewState value) {
    profileViewState = value;
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
  pickAndUpload(BuildContext context) async{
    try {
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
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: successColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            alignment: Alignment.bottomLeft,
            insetPadding: const EdgeInsets.only(bottom: 60, left: 60),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.done, color: successColor, size: 18,),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("Profile Picture Updated", style: TextStyle(color: Colors.white, fontSize: l, fontWeight: FontWeight.w700),),
                  const SizedBox(width: 50),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch(e) {
      toastMessage(message: e.toString());
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