import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:stacked/stacked.dart';

class CustomerListViewModel extends BaseViewModel {

  List<Customer> customers = Data.customers;

  List<String> sortList = [
    "Sort by default",
    "Sort by default 2",
    "Sort by default 3",
  ];

  String _sortBy = "Sort by default";
  String get sortBy => _sortBy;

  selectSortBy(String value) {
    _sortBy = value;
    notifyListeners();
  }

  int pageNumber = 1;
  changePage(int value) async{
    pageNumber = value;
    // _resultLimit = ResultLimit.ten;
    //
    // await selectDataAccordingToPage();
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
  }

  TextEditingController searchTEC = TextEditingController();


  updateUI() {
    notifyListeners();
  }

  disposeResource() {
    searchTEC.dispose();
  }

}