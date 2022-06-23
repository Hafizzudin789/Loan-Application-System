import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
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

    // if(filteredList.isEmpty) {
    //   toastMessage(message: "No result found");
    // }
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



  ////Date Amount Filter Login Start//
  List<String> customFilterList = [
    "Date",
    "Amount",
    "Reset Filter",
  ];

  TextEditingController fromTEC = TextEditingController();
  TextEditingController toTEC = TextEditingController();

  String? fromDate;
  String? toDate;

  selectDate(BuildContext context, TextEditingController textEditingController, bool isFrom) async{
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 200),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly
    );

    if(newDate != null) {
      textEditingController.text = "${newDate.day}/${newDate.month}/${newDate.year}";
      if(isFrom) {
        fromDate = newDate.toString();
      } else {
        toDate = newDate.toString();
      }
      notifyListeners();
    }
  }

  applyDateFilter() {
    if(fromTEC.text.isEmpty || toTEC.text.isEmpty || fromDate==null || toDate == null) {
      return;
    }
    locator<NavigationService>().goBack();
    locator<NavigationService>().goBack();

    //clearing amount filter
    minAmountTEC.clear();
    maxAmountTEC.clear();

    dateOrAmountFilterApplied = true;
    selectDataAccordingToPage();

    List<CustomerApplications> data = customerApplications.where((element) => DateTime.parse(fromDate!).compareTo(DateTime.parse(element.createdDate))<=0 && DateTime.parse(toDate!).compareTo(DateTime.parse(element.createdDate))>=0).toList();
    customerApplications = data;
    notifyListeners();
  }


  TextEditingController minAmountTEC = TextEditingController();
  TextEditingController maxAmountTEC = TextEditingController();

  applyAmountFilter() {
    if(minAmountTEC.text.isEmpty || maxAmountTEC.text.isEmpty || maxAmountTEC.text.trim() == "BHD" || minAmountTEC.text.trim() == "BHD") {
      return;
    }
    locator<NavigationService>().goBack();
    locator<NavigationService>().goBack();

    //clearing date filter
    fromTEC.clear();
    toTEC.clear();
    fromDate == null;
    toDate == null;

    dateOrAmountFilterApplied = true;
    selectDataAccordingToPage();

    String minAm = minAmountTEC.text.replaceAll("BHD ", "").trim();
    String maxAm = maxAmountTEC.text.replaceAll("BHD ", "").trim();
    List<CustomerApplications> data = customerApplications.where((element) => double.parse(minAm)<=element.financeAmount && element.financeAmount<=double.parse(maxAm)).toList();
    customerApplications = data;
    notifyListeners();
  }

  bool dateOrAmountFilterApplied = false;
  resetFilters() {
    locator<NavigationService>().goBack();

    fromTEC.clear();
    toTEC.clear();
    fromDate == null;
    toDate == null;

    minAmountTEC.clear();
    maxAmountTEC.clear();

    dateOrAmountFilterApplied = false;
    selectDataAccordingToPage();

    notifyListeners();
  }
  ////Date Amount Filter Login End//



  ////Search Logic Start//
  TextEditingController searchTEC = TextEditingController();
  searchCustomerApplications() {
    // if(searchTEC.text.isEmpty) {
    //   return;
    // }
    selectDataAccordingToPage();
    List<CustomerApplications> data = customerApplications.where((element) => _contains(element)).toList();
    customerApplications = data;
    notifyListeners();
  }

  bool _contains(CustomerApplications data) {
    return data.cifNo == searchTEC.text || data.applicantName == searchTEC.text || data.mobileNumber == searchTEC.text
        || data.applicationId == searchTEC.text || data.applicantEmail == searchTEC.text;
  }

  updateUI() {
    notifyListeners();
  }

  ////Search Logic End//

  disposeResource() {
    searchTEC.dispose();
    fromTEC.dispose();
    toTEC.dispose();
    minAmountTEC.dispose();
    maxAmountTEC.dispose();
  }

}