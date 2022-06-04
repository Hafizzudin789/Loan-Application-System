import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/application_form_view/card_page.dart';

class ApplicationFormView extends StatefulWidget {
  const ApplicationFormView({Key? key}) : super(key: key);

  @override
  State<ApplicationFormView> createState() => _ApplicationFormViewState();
}

class _ApplicationFormViewState extends State<ApplicationFormView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [errorColor, primaryColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20.0, top: 40, bottom: 30),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/formIcon.svg", color: Colors.white,),
                            const SizedBox(width: 10),
                            const Expanded(child: Text("NEW APPLICATION", style: TextStyle(color: Colors.white, fontSize: s, fontWeight: FontWeight.w700, letterSpacing: 1.5,),)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _menuButton("Card Page"),
                              _menuButton("Customer ID"),
                              _menuButton("Customer Details"),
                              _menuButton("Card Selection"),
                              _menuButton("Documents"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 9,
                child: CardPage()
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String label) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), topLeft: Radius.circular(100)),
        ),
        child: Text(label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: m,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
