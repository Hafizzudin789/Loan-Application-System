import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loan Application System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Avenir",
          textTheme: const TextTheme(
            // bodyText1: TextStyle(
            //   color: Colors.red,
            // ),
            bodyText2: TextStyle(
              color: blackColor,
            ),
            headline1: TextStyle(
              color: blackColor,
              fontSize: xxxxl,
              fontWeight: FontWeight.w700,
            )

          )
        ),
        home: const SplashView(),
      ),
    );
  }
}
