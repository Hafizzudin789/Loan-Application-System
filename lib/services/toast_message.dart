import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage({required String message, Color backgroundColor = Colors.black, Color textColor = Colors.white,
  int timeInSecForIosWeb = 2, Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.CENTER
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: toastGravity,
    timeInSecForIosWeb: timeInSecForIosWeb,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
