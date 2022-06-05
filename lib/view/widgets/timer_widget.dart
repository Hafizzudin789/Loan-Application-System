import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/logout_view.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  int counter = 20;
  late Timer _timer;

  @override
  initState() {
    super.initState();
    startCounter();
  }

  @override
  dispose() {
    super.dispose();
    _timer.cancel();
  }

  startCounter() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(counter <=0) {
        _timer.cancel();
        setState((){});
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogoutView(isSessionExpired: true,)), (route) => false);
        return;
      }
      counter--;
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("Your session will expire in 00:$counter", style: const TextStyle(fontSize: xl, fontWeight: FontWeight.w600, color: warningColor));
  }
}
