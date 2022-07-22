import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/services/toast_message.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:stacked/stacked.dart';

class CustomerProfileViewModel extends BaseViewModel {

  initialize(String customerName) {
    fullNameTEC.text = customerName;

    //For viewing customer profile
    mobileNumberTEC.text = "d+971 29384902";
    emailTEC.text = "dias@test.com";

    employmentStatusTEC.text = "Full-Time Employee";
    employmentName.text = "ABC Group";
    monthlySalary.text = "BHD 3,440.00";
    notifyListeners();
  }

  bool isCustomerIdExpired(String customerName) {
    if(customerName == "Paco Aguilar") {
      return true;
    } else {
      return false;
    }
  }

  final fullNameTEC = TextEditingController(text: "Faisal Saeed Ahmed Mohamed Qamar Alzaman");
  final nationalityTEC = TextEditingController(text: "Bahrainian");
  final birthDateTEC = TextEditingController(text: "14 / 02 / 89");
  final idTypeTEC = TextEditingController(text: "Passport");
  final idNumberTEC = TextEditingController(text: "A47745683");
  final expiryDateTEC = TextEditingController(text: "14 / 02 / 2023");

  final mobileNumberTEC = TextEditingController();
  final emailTEC = TextEditingController();

  final employmentStatusTEC = TextEditingController();
  final employmentName = TextEditingController();
  final monthlySalary = TextEditingController();

  bool _isEditable = false;
  bool get isEditable => _isEditable;
  changeEditCustomerProfileDataBool() {
    _isEditable = !_isEditable;
    notifyListeners();
  }
//////////////////////////////////


  final ibanTEC = TextEditingController(text: "BH67 KFHW 0000 1299 1234 56");
  final accountType = TextEditingController(text: "Saving Account");
  final statusTEC = TextEditingController(text: "Active");
  final accountBalance = TextEditingController(text: "BHD 12,000.00");

  CustomerProfileViewState customerProfileViewState = CustomerProfileViewState.profile;
  changeState(CustomerProfileViewState value) {
    customerProfileViewState = value;
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
        notifyListeners();
      }

    } catch(e) {
      toastMessage(message: e.toString());
    }
  }



  List<ProductModel> productsModel = Data.productModelList;
  TextEditingController searchTEC = TextEditingController();
  updateUI() {
    notifyListeners();
  }

  disposeResource() {
    fullNameTEC.dispose();
    emailTEC.dispose();
    birthDateTEC.dispose();
    nationalityTEC.dispose();
    idTypeTEC.dispose();
    idNumberTEC.dispose();
    expiryDateTEC.dispose();
    mobileNumberTEC.dispose();
    employmentStatusTEC.dispose();
    employmentName.dispose();
    monthlySalary.dispose();


    ibanTEC.dispose();
    accountType.dispose();
    statusTEC.dispose();
    accountBalance.dispose();

    searchTEC.dispose();
  }
}