import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/application_form_view/card_page.dart';
import 'package:loan_application_system/view/application_form_view/card_selection_page.dart';
import 'package:loan_application_system/view/application_form_view/customer_details_page.dart';
import 'package:loan_application_system/view/application_form_view/customer_id_page.dart';
import 'package:loan_application_system/view/application_form_view/doucments_page.dart';
import 'package:stacked/stacked.dart';

class ApplicationFormViewModel extends BaseViewModel {

  ApplicationFormState applicationFormState = ApplicationFormState.cardPage;
  changeApplicationFormState(ApplicationFormState value) {
    applicationFormState = value;
    changeProgressValue(value);
    notifyListeners();
  }

  applicationFormPage({required List<CardTypeData> cardData, required ApplicationFormViewModel viewModel}) {
    return applicationFormState == ApplicationFormState.cardPage
        ? CardPage(
            cardData: cardData,
            viewModel: viewModel,
          )
        : applicationFormState == ApplicationFormState.customerId
            ? const CustomerIdPage()
            : applicationFormState == ApplicationFormState.customerDetails
                ? const CustomerDetailsPage()
                : applicationFormState == ApplicationFormState.cardSelection
                    ? const CardSelectionPage()
                    : const DocumentsPage();
  }

  double _progressValue = 0;
  double get progressValue => _progressValue;
  changeProgressValue(ApplicationFormState value) {
    if(value == ApplicationFormState.cardPage) {
      if(_cardSelected.contains(true)) {
        _progressValue = 0.2;
      }
    } else if (value == ApplicationFormState.customerId) {
      _progressValue = 0.4;
    } else if (value == ApplicationFormState.customerDetails) {
      _progressValue = 0.6;
    } else if(value == ApplicationFormState.cardSelection) {
      _progressValue = 0.8;
    } else {
      _progressValue = 0.8;
    }
  }



  //Card Page//

  List<bool> _cardSelected = [];
  List<bool> get cardSelected => _cardSelected;
  selectCard(int index) {
    _cardSelected[index] = !_cardSelected[index];
    changeProgressValue(applicationFormState);
    notifyListeners();
  }

  initializeCardSelectedList(int length) {
    _cardSelected = List.filled(length, false);
    notifyListeners();
  }
  //Card Page End//



  //Customer Id//

  String? frontIdImagePath;
  String? backIdImagePath;

  setFrontIdImagePath(String? value) {
    frontIdImagePath = value;
    notifyListeners();
  }

  setBackIdImagePath(String? value) {
    backIdImagePath = value;
    notifyListeners();
  }
  //Customer Id End//


  //Customer Details//

  TextEditingController phoneNumberTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController employmentStatusTEC = TextEditingController();
  TextEditingController monthlySalaryTEC = TextEditingController();
  TextEditingController companyTEC = TextEditingController();

  bool agreedToTerms = false;
  agreeToTerms() {
    agreedToTerms = !agreedToTerms;
    notifyListeners();
  }
  bool customerDetailIsComplete() {
    return phoneNumberTEC.text.isNotEmpty && emailTEC.text.isNotEmpty
        && employmentStatusTEC.text.isNotEmpty && monthlySalaryTEC.text.isNotEmpty
        && companyTEC.text.isNotEmpty && agreedToTerms;
  }
  //Customer Details End//
}