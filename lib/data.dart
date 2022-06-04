import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';

class Data {

  static const String emailId = "digibanc@gmail.com";
  static const String password = "Digibanc123";

  static const String otpCode = "123456";

  static List<CardTypeData> cardTypeData = [
    CardTypeData(label: "Digibanc Cash Back Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.svg", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: null, borderColor: const Color(0XFFD64951).withOpacity(0.2)),
    CardTypeData(label: "Digibanc JustOne Visa Platinum Card", annualFee: "Free*", cardType: "assets/visaCardIcon.svg", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: primaryColor, borderColor: primaryGrey),
    CardTypeData(label: "Digibanc JustOne Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.svg", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: lightYellowColor, borderColor: const Color(0XFFD64951).withOpacity(0.2)),
    CardTypeData(label: "Digibanc JustOne Platinum MasterCard", annualFee: "Free*", cardType: "assets/visaCardIcon.svg", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: orangeColor, borderColor: primaryGrey),
    CardTypeData(label: "Digibanc Cash Back Platinum MasterCard", annualFee: "Free*", cardType: "assets/masterCardIcon.svg", feature: "Rewards", minimumIncome: 600, rewardsUpTo: "up to 8x", cardColor: primaryColor, borderColor: const Color(0XFFD64951).withOpacity(0.2)),
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
  final Color borderColor;
  CardTypeData({required this.label, required this.annualFee, required this.cardType, required this.feature, required this.minimumIncome, required this.rewardsUpTo, this.cardColor, required this.borderColor});
}