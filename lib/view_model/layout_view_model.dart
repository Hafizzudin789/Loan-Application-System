import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/layout_view/tab_navigator_Widget.dart';
import 'package:stacked/stacked.dart';


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