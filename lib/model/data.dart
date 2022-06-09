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
    CustomerApplications(applicantEmail: "vaccaro@mail.com", applicantName: "Carla Vaccaro", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 32942.34, mobileNumber: "+971 335565", product: "Auto Finance", type: "Toyota", status: CustomerApplicationStatus.newA),
    CustomerApplications(applicantEmail: "kenter@mail.com", applicantName: "Ruben Kenter", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 78000.00, mobileNumber: "+971 335565", product: "Credit Card", type: "Honda", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "dorwart@mail.com", applicantName: "Davis Dorwart", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 323942.34, mobileNumber: "+971 335565", product: "Auto Finance", type: "Visa Platinum", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "donin@mail.com", applicantName: "Mira Donin", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 52942.34, mobileNumber: "+971 335565", product: "Personal Finance", type: "-", status: CustomerApplicationStatus.declined),
    CustomerApplications(applicantEmail: "geidt@mail.com", applicantName: "Terry Geidt", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 2942.34, mobileNumber: "+971 335565", product: "Auto Finance", type: "Toyota", status: CustomerApplicationStatus.delivery),
    CustomerApplications(applicantEmail: "kenter@mail.com", applicantName: "Tatiana Kenter", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 4562942.34, mobileNumber: "+971 335565", product: "Auto Finance", type: "Toyota", status: CustomerApplicationStatus.complete),
    CustomerApplications(applicantEmail: "westervelt@mail.com", applicantName: "Roger Westervelt", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 42942.34, mobileNumber: "+971 335565", product: "Personal Finance", type: "-", status: CustomerApplicationStatus.delivery),
    CustomerApplications(applicantEmail: "passaquindic@mail.com", applicantName: "Cristofer Passaquindic", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 92942.34, mobileNumber: "+971 335565", product: "Auto Finance", type: "Visa Platinum", status: CustomerApplicationStatus.processing),
    CustomerApplications(applicantEmail: "ronaldo@mail.com", applicantName: "Cristiano Ronaldo", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 12942.34, mobileNumber: "+971 335565", product: "Credit Card", type: "Toyota", status: CustomerApplicationStatus.accepted),
    CustomerApplications(applicantEmail: "rosser@mail.com", applicantName: "Adison Rosser", applicationId: "34300040053", cifNo: "3435000040053-3", createdDate: "22/5/2022", financeAmount: 342942.34, mobileNumber: "+971 335565", product: "Credit Card", type: "-", status: CustomerApplicationStatus.accepted),
  ];

}

class ApplicationData {
  final String label;
  final int value;
  ApplicationData(this.value, this.label);
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
  final String product;
  final String type;
  final String applicationId;
  final String cifNo;
  final String createdDate;
  final String mobileNumber;
  final CustomerApplicationStatus status;

  CustomerApplications({required this.applicantEmail, required this.applicantName, required this.applicationId, required this.cifNo, required this.createdDate, required this.financeAmount, required this.mobileNumber, required this.product, required this.type, required this.status});
}