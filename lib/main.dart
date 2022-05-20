import 'package:flutter/material.dart';
import 'package:loan_application_system/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loan Application System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}
