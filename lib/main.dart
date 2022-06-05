import 'package:flutter/material.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/layout_view/layout_view.dart';
import 'package:loan_application_system/view/splash_view.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';

void main() async {
  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutViewModel>.nonReactive(
      viewModelBuilder: () => LayoutViewModel(),
      builder: (context, viewModel, _) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Loan Application System',
            theme: ThemeData(
              scaffoldBackgroundColor: primaryGrey,
              primaryColor: blackColorMono,
              fontFamily: "Avenir",
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: darkGreyColor,
                  fontSize: s,
                ),
                bodyText2: TextStyle(
                  color: darkGreyColor,
                ),
                headline1: TextStyle(
                  color: blackColorMono,
                  fontSize: xxxxl,
                  fontWeight: FontWeight.w700,
                ),
                headline2: TextStyle(
                  color: blackColorMono,
                  fontSize: xxl,
                  fontWeight: FontWeight.w700,
                ),
                headline3: TextStyle(
                  color: blackColorMono,
                  fontSize: l,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            home: const SplashView(),
            // home: const LayoutView(),
          ),
        );
      },
    );
  }
}
