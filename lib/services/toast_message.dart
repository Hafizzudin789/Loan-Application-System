import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage({required String message, Color backgroundColor = Colors.black, Color textColor = Colors.white, int timeInSecForIosWeb=3, Toast toastLength = Toast.LENGTH_LONG}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: timeInSecForIosWeb,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
