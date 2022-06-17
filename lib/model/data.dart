import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';

class Data {

  static const String emailId = "digibanc@gmail.com";
  static const String password = "Digibanc123";

  static const String otpCode = "123456";

  static List<CardTypeData> cardTypeData = [
    CardTypeData(label: "Digibanc Cash Back Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: null),
    CardTypeData(label: "Digibanc JustOne Visa Platinum Card", annualFee: "Free*", cardType: "assets/visaCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: primaryColor),
    CardTypeData(label: "Digibanc JustOne Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: lightYellowColor),
    CardTypeData(label: "Digibanc JustOne Platinum MasterCard", annualFee: "Free*", cardType: "assets/visaCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: orangeColor),
    CardTypeData(label: "Digibanc Cash Back Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: primaryColor),
  ];

  static List<CardTypeData> limitedCardData = [
    CardTypeData(label: "Digibanc Cash Back Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: null),
    CardTypeData(label: "Digibanc JustOne Visa Platinum Card", annualFee: "Free*", cardType: "assets/visaCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: primaryColor),
  ];

  static List<CardTypeData> cardSelection = [
    CardTypeData(label: "Digibanc JustOnePlatinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: primaryColor),
    CardTypeData(label: "Digibanc JustOne Visa Platinum Card", annualFee: "Free*", cardType: "assets/masterCardIcon.png", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: lightYellowColor),
  ];
  
  static List<CustomerApplications> customerApplications = [
    CustomerApplications(applicantEmail: "vaccaro@mail.com", applicantName: "Carla Vaccaro", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-11T16:14:43.595939Z", financeAmount: 32942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Toyota", status: CustomerApplicationStatus.newA),
    CustomerApplications(applicantEmail: "kenter@mail.com", applicantName: "Ruben Kenter", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-05-10T16:14:43.595939Z", financeAmount: 78000.00, mobileNumber: "+971 335565", product: Product.creditCard, type: "Honda", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "dorwart@mail.com", applicantName: "Davis Dorwart", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-04-09T16:14:43.595939Z", financeAmount: 323942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Visa Platinum", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "donin@mail.com", applicantName: "Mira Donin", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-01-05T16:14:43.595939Z", financeAmount: 52942.34, mobileNumber: "+971 335565", product: Product.personalFinance, type: "-", status: CustomerApplicationStatus.declined),
    CustomerApplications(applicantEmail: "geidt@mail.com", applicantName: "Terry Geidt", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-02-14T16:14:43.595939Z", financeAmount: 2942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Toyota", status: CustomerApplicationStatus.delivery),
    CustomerApplications(applicantEmail: "kenter@mail.com", applicantName: "Tatiana Kenter", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-03-17T16:14:43.595939Z", financeAmount: 4562942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Toyota", status: CustomerApplicationStatus.complete),
    CustomerApplications(applicantEmail: "westervelt@mail.com", applicantName: "Roger Westervelt", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-05-17T16:14:43.595939Z", financeAmount: 42942.34, mobileNumber: "+971 335565", product: Product.personalFinance, type: "-", status: CustomerApplicationStatus.delivery),
    CustomerApplications(applicantEmail: "passaquindic@mail.com", applicantName: "Cristofer Passaquindic", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-16T16:14:43.595939Z", financeAmount: 92942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Visa Platinum", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "ronaldo@mail.com", applicantName: "Cristiano Ronaldo", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-15T16:14:43.595939Z", financeAmount: 12942.34, mobileNumber: "+971 335565", product: Product.creditCard, type: "Toyota", status: CustomerApplicationStatus.accepted),
    CustomerApplications(applicantEmail: "rosser@mail.com", applicantName: "Adison Rosser", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-04-14T16:14:43.595939Z", financeAmount: 342942.34, mobileNumber: "+971 335565", product: Product.creditCard, type: "-", status: CustomerApplicationStatus.accepted),

    CustomerApplications(applicantEmail: "badacaro@mail.com", applicantName: "Leo Vaccaro", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-03-14T16:14:43.595939Z", financeAmount: 32942.34, mobileNumber: "+971 335565", product: Product.creditCard, type: "Honda", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "vdav@mail.com", applicantName: "Cavani Kenter", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-05-14T16:14:43.595939Z", financeAmount: 78000.00, mobileNumber: "+971 335565", product: Product.personalFinance, type: "Toyota", status: CustomerApplicationStatus.newA),
    CustomerApplications(applicantEmail: "ddaw@mail.com", applicantName: "Kim Dorwart", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-02-14T16:01:43.595939Z", financeAmount: 323942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Visa Platinum", status: CustomerApplicationStatus.declined),
    CustomerApplications(applicantEmail: "diamong@mail.com", applicantName: "Mira Tornado", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-01-09T16:14:43.595939Z", financeAmount: 52942.34, mobileNumber: "+971 335565", product: Product.creditCard, type: "-", status: CustomerApplicationStatus.delivery),
    CustomerApplications(applicantEmail: "have@mail.com", applicantName: "Berry Geidt", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-14T16:15:43.595939Z", financeAmount: 2942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Toyota", status: CustomerApplicationStatus.complete),
    CustomerApplications(applicantEmail: "kater@mail.com", applicantName: "Duke Pater", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-14T16:10:43.595939Z", financeAmount: 4562942.34, mobileNumber: "+971 335565", product: Product.personalFinance, type: "Visa Platinum", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "karen@mail.com", applicantName: "Roger Allsdoin", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-14T11:14:43.595939Z", financeAmount: 42942.34, mobileNumber: "+971 335565", product: Product.personalFinance, type: "-", status: CustomerApplicationStatus.accepted),
    CustomerApplications(applicantEmail: "haluwa@mail.com", applicantName: "Bush Passaquindic", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-14T16:14:43.595939Z", financeAmount: 92942.34, mobileNumber: "+971 335565", product: Product.creditCard, type: "Visa Platinum", status: CustomerApplicationStatus.delivery),
    CustomerApplications(applicantEmail: "haveafbva@mail.com", applicantName: "Hafiz Ronaldo", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-14T16:14:43.595939Z", financeAmount: 12942.34, mobileNumber: "+971 335565", product: Product.personalFinance, type: "Toyota", status: CustomerApplicationStatus.accepted),
    CustomerApplications(applicantEmail: "rose@mail.com", applicantName: "Bidhan Rosser", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-15T16:14:43.595939Z", financeAmount: 342942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "-", status: CustomerApplicationStatus.accepted),

    CustomerApplications(applicantEmail: "Hero@mail.com", applicantName: "Hero Shetty", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-17T16:14:43.595939Z", financeAmount: 32942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Toyota", status: CustomerApplicationStatus.newA),
    CustomerApplications(applicantEmail: "Ramesh@mail.com", applicantName: "Ramesh Kenter", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-10T16:14:43.595939Z", financeAmount: 78000.00, mobileNumber: "+971 335565", product: Product.creditCard, type: "Honda", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "Hafiz@mail.com", applicantName: "Hafiz Dorwart", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-11T16:14:43.595939Z", financeAmount: 323942.34, mobileNumber: "+971 335565", product: Product.autoFinance, type: "Visa Platinum", status: CustomerApplicationStatus.complete),
    CustomerApplications(applicantEmail: "Angel@mail.com", applicantName: "Angel Donin", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "2022-06-14T16:14:43.595939Z", financeAmount: 52942.34, mobileNumber: "+971 335565", product: Product.personalFinance, type: "-", status: CustomerApplicationStatus.declined),
  ];


  static List<ApplicationStatusModel> allApplicationCountData = [
    ApplicationStatusModel(380, "Completed"),
    ApplicationStatusModel(250, "In Progress"),
    ApplicationStatusModel(160, "Rejected"),
  ];

  static List<ApplicationStatusModel> creditCardApplicationCountData = [
    ApplicationStatusModel(232, "Completed"),
    ApplicationStatusModel(51, "In Progress"),
    ApplicationStatusModel(9, "Rejected"),
  ];

  static List<ApplicationStatusModel> autoFinanceApplicationCountData = [
    ApplicationStatusModel(100, "Completed"),
    ApplicationStatusModel(25, "In Progress"),
    ApplicationStatusModel(50, "Rejected"),
  ];

  static List<ApplicationStatusModel> personalFinanceApplicationCountData = [
    ApplicationStatusModel(48, "Completed"),
    ApplicationStatusModel(174, "In Progress"),
    ApplicationStatusModel(101, "Rejected"),
  ];

  static List<ApplicationDataModel> allData = [
    ApplicationDataModel(45, "Credit\nCard", errorColor),
    ApplicationDataModel(21, "Personal\nFinance", yellowColor),
    ApplicationDataModel(14, "Auto\nFinance", greenColor),
  ];

  static List<ApplicationDataModel> creditCardData = [
    ApplicationDataModel(23, "Platinum", errorColor),
    ApplicationDataModel(51, "Gold", yellowColor),
    ApplicationDataModel(14, "Silver", greenColor),
  ];

  static List<ApplicationDataModel> autoFinanceData = [
    ApplicationDataModel(30, "Toyota", errorColor),
    ApplicationDataModel(20, "Mercedes", yellowColor),
    ApplicationDataModel(45, "Volkwagen", greenColor),
  ];

  static List<ApplicationDataModel> personalFinanceData = [
    ApplicationDataModel(20, "Facility 1", errorColor),
    ApplicationDataModel(50, "Facility 2", yellowColor),
    ApplicationDataModel(14, "Facility 3", greenColor),
  ];
}

class ApplicationStatusModel {
  final String label;
  final int value;
  ApplicationStatusModel(this.value, this.label);
}

class ApplicationDataModel {
  final String label;
  final int value;
  final Color color;
  ApplicationDataModel(this.value, this.label, this.color);
}

class TypesCountData {
  final String label;
  final int value;
  TypesCountData({required this.label, required this.value});
}

class CardTypeData {
  final String label;
  final double minimumIncome;
  final String feature;
  final String rewardsUpTo;
  final String annualFee;
  final String cardType;
  final Color? cardColor;
  CardTypeData({required this.label, required this.annualFee, required this.cardType, required this.feature, required this.minimumIncome, required this.rewardsUpTo, this.cardColor});
}

class CustomerApplications {
  final String applicantName;
  final double financeAmount;
  final String applicantEmail;
  final Product product;
  final String type;
  final String applicationId;
  final String cifNo;
  final String createdDate;
  final String mobileNumber;
  final CustomerApplicationStatus status;

  CustomerApplications({required this.applicantEmail, required this.applicantName, required this.applicationId, required this.cifNo, required this.createdDate, required this.financeAmount, required this.mobileNumber, required this.product, required this.type, required this.status});
}