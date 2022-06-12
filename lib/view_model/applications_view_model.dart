import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/services/toast_message.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:stacked/stacked.dart';

class ApplicationsViewModel extends BaseViewModel {

  List<CustomerApplications> customerApplications = [];

  initializeApplicationsList() {
    customerApplications = Data.customerApplications.sublist(0,resultLimit.value);
    notifyListeners();
  }

  int pageNumber = 1;
  changePage(int value) async{
    pageNumber = value;
    _resultLimit = ResultLimit.ten;

    await selectDataAccordingToPage();
    notifyListeners();
  }

  selectDataAccordingToPage() {
    if(pageNumber == 1) {
      customerApplications = Data.customerApplications.sublist(0,10);
    } else if(pageNumber == 2) {
      customerApplications = Data.customerApplications.sublist(10,20);
    } else {
      customerApplications = Data.customerApplications.sublist(20,24);
    }
  }

  List<Product> products = [
    Product.all,
    Product.creditCard,
    Product.autoFinance,
    Product.personalFinance,
  ];

  Product _productTypeSelected = Product.all;
  Product get productTypeSelected => _productTypeSelected;

  selectProductType(Product value) {
    _productTypeSelected = value;
    applyingFilter();
  }

  List<CustomerApplicationStatus> applicationStatusList = [
    CustomerApplicationStatus.all,
    CustomerApplicationStatus.complete,
    CustomerApplicationStatus.processing,
    CustomerApplicationStatus.delivery,
    CustomerApplicationStatus.declined,
    CustomerApplicationStatus.newA,
    CustomerApplicationStatus.accepted,
  ];

  CustomerApplicationStatus _applicationStatus = CustomerApplicationStatus.all;
  CustomerApplicationStatus get applicationStatus => _applicationStatus;

  selectApplicationStatus(CustomerApplicationStatus value) {
    _applicationStatus = value;
    applyingFilter();
  }

  applyingFilter() async{
    await selectDataAccordingToPage();

    List<CustomerApplications> filteredList = customerApplications
        .where((e) => ((_applicationStatus == CustomerApplicationStatus.all
            ? true
            : e.status == _applicationStatus)
        && (_productTypeSelected == Product.all
            ? true
            : e.product == _productTypeSelected)))
        .toList();

    if(filteredList.isEmpty) {
      toastMessage(message: "No result found");
    }
    customerApplications = filteredList;
    notifyListeners();
  }

  ResultLimit _resultLimit = ResultLimit.ten;
  ResultLimit get resultLimit => _resultLimit;

  List<ResultLimit> resultLimitList = [
    ResultLimit.ten,
    ResultLimit.twenty,
    ResultLimit.thirty,
    ResultLimit.forty,
    ResultLimit.fifty,
  ];

  changeResultLimit(ResultLimit value) {
    _resultLimit = value;

    switch(value){
      case ResultLimit.ten:
        if(pageNumber == 1) {
          customerApplications = Data.customerApplications.sublist(0, 10);
        } else if (pageNumber == 2){
          customerApplications = Data.customerApplications.sublist(10, 20);
        }
        break;
      case ResultLimit.twenty:
        if(pageNumber == 1) {
          customerApplications = Data.customerApplications.sublist(0, 20);
        } else if (pageNumber == 2){
          customerApplications = Data.customerApplications.sublist(10, 24);
        }
        break;
      default:
        if(pageNumber == 1) {
          customerApplications = Data.customerApplications.sublist(0, 24);
        } else if (pageNumber == 2){
          customerApplications = Data.customerApplications.sublist(10, 24);
        }
        break;
    }
    notifyListeners();
  }

  //
  // bool searchMatched(CustomerApplications value) {
  //   if(value.product.value == searchTEC.text || value.applicantName == searchTEC.text || value.financeAmount.toString() == searchTEC.text
  //     || value.applicantEmail == searchTEC.text || value.cifNo == searchTEC.text || value.type == searchTEC.text || value.applicationId == searchTEC.text
  //     || value.mobileNumber == searchTEC.text) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // search() {
  //   notifyListeners();
  // }

  TextEditingController searchTEC = TextEditingController();
  disposeResource() {
    searchTEC.dispose();
  }

}