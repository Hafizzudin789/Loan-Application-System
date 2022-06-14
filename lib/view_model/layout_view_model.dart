import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/layout_view/tab_navigator_Widget.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';


class LayoutViewModel extends BaseViewModel {

  late Timer timerForSession;

  LayoutViewIndex _layoutViewIndex = LayoutViewIndex.dashboardView;
  LayoutViewIndex get layoutViewIndex => _layoutViewIndex;

  changeLayoutViewIndex(LayoutViewIndex value) async{
    // //if press the same bottom navbar item pop if can
    if(_layoutViewIndex == value) {
      await locator<NavigationService>().navigatorKeys[_layoutViewIndex.name]!.currentState!.maybePop();
    return;
    }
    _layoutViewIndex = value;
    locator<NavigationService>().layoutIndex = value;
    notifyListeners();
  }

  justChangeLayoutViewIndex(LayoutViewIndex value) {
    _layoutViewIndex = value;
    locator<NavigationService>().layoutIndex = value;
  }

  buildOffstageNavigator(LayoutViewIndex layoutIndex) {
    return Offstage(
      offstage: _layoutViewIndex != layoutIndex,
      child: TabNavigator(
        navigatorKey: locator<NavigationService>().navigatorKeys[layoutIndex.name]!,
        bottomIndex: layoutIndex,
      ),
    );
  }


  ////Dashboard View logic

  String totalVolume = "42,000,000.00";
  List<ApplicationStatusModel> applicationsCountData = Data.allApplicationCountData;
  int getTotalSelectedApplicationsCount() {
    List<int> listOfInt = applicationsCountData.map((e) => e.value).toList();
    return listOfInt.sum;
  }

  List<ApplicationDataModel> applicationData = Data.allData;

  
  Product _dashboardState = Product.all;
  Product get dashboardState => _dashboardState;

  changeDashboardState(Product value) {
    switch(value) {
      case Product.creditCard:
        totalVolume = "420,000.00";
        applicationsCountData = Data.creditCardApplicationCountData;
        applicationData = Data.creditCardData;
        break;
      case Product.autoFinance:
        totalVolume = "147,000.00";
        applicationsCountData = Data.autoFinanceApplicationCountData;
        applicationData = Data.autoFinanceData;
        break;
      case Product.personalFinance:
        totalVolume = "360,000.00";
        applicationsCountData = Data.personalFinanceApplicationCountData;
        applicationData = Data.personalFinanceData;
        break;
      default:
        totalVolume = "42,000,000.00";
        applicationsCountData = Data.allApplicationCountData;
        applicationData = Data.allData;
        break;
    }
    _dashboardState = value;
    notifyListeners();
  }

  List<Product> products = [
    Product.all,
    Product.creditCard,
    Product.autoFinance,
    Product.personalFinance,
  ];

  String selectedYear = "2022";
  List<String> dropdownYear = ["2022","2021","2020", "2019", "2018", "2017"];
  selectDropDownYear(String value) {
    selectedYear = value;
    notifyListeners();
  }

  String selectedMonth = "All Month";
  List<String> dropdownMonth = ["All Month","January","February", "March", "April", "May", "June", "July", "August", "September", "October",
    "November", "December"];
  selectDropDownMonth(String value) {
    selectedMonth = value;
    notifyListeners();
  }
  ////Dashboard View logic End





  ///////add application pop up view state/////////////////////
  final monthlyIncomeTEC = TextEditingController();

  CustomerType? customerType;
  selectCustomerType(CustomerType? value) {
    if(value == null) {
      return;
    }
    customerType = value;
  }

  bool allCardPrefSelected = false;
  selectAllCardPref(bool? value) {
    if(value == null) {
      return;
    }
    if(value) {
      cardPrefList = cardPrefList.map((e) => true).toList();
    } else {
      cardPrefList = cardPrefList.map((e) => false).toList();
    }
    allCardPrefSelected = value;
  }

  List<bool> cardPrefList = [false, false, false, false, false, false, false];
  selectCardPref(int index) {
    if(cardPrefList[index]){
      allCardPrefSelected = false;
    }
    cardPrefList[index] = !cardPrefList[index];
    if(!cardPrefList.contains(false)) {
      allCardPrefSelected = true;
    }
  }

  String dropdownValue = '25 %';
  var items = [
    '5 %',
    '25 %',
    '50 %',
    '100 %',
  ];

  disposeCardResource() {
    dropdownValue = '25 %';
    customerType = null;
    selectAllCardPref(false);
    monthlyIncomeTEC.clear();
  }
  //add application pop up view state end/////////////////////////////////////



}