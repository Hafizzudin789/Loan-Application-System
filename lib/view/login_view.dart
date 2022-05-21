import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/footer.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.all(40),
                    constraints: BoxConstraints.loose(
                      const Size(380, double.infinity),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Color.fromARGB(10, 14, 49, 81), blurRadius: 10, spreadRadius: 0.1)
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/appLogo.png", height: 32,),
                          const SizedBox(height: 10),
                          const Text("Log in to your account", style: TextStyle(color: monochromeBlackColor, fontWeight: FontWeight.w600, fontSize: l),),
                          const SizedBox(height: 60),

                          const Text("Email Address", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w500),),
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            onChanged: (value) {
                              setState((){});
                            },
                            decoration: InputDecoration(
                              hintText: "example@test.com",
                              hintStyle: const TextStyle(color: lightGreyColor, fontWeight: FontWeight.w700),
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _emailController.text.isNotEmpty?pinkColor:greyColor)),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: pinkColor)),
                            ),
                          ),

                          const SizedBox(height: 30),

                          const Text("Password", style: TextStyle(fontSize: s, color: darkGreyColor),),
                          TextFormField(
                            controller: _passwordController,
                            onChanged: (value) {
                              setState((){});
                            },
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "case-sensitive",
                              hintStyle: const TextStyle(color: lightGreyColor, fontWeight: FontWeight.w700),
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _passwordController.text.isNotEmpty?pinkColor:greyColor)),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: pinkColor)),
                            ),
                          ),

                          const SizedBox(height: 60),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  "Forgot Login?",
                                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: pinkColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        title: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: const Icon(Icons.close, color: pinkColor, size: 18,),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: const [
                                                Text("Invalid email address or password.", style: TextStyle(color: Colors.white, fontSize: l, fontWeight: FontWeight.w700),),
                                                SizedBox(height: 10),
                                                Text("Click on ‘Forgot Login?' to reset your login details.", style: TextStyle(color: Colors.white, fontSize: m),),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            const Icon(Icons.close, color: Colors.white, size: 18),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty
                                      ? buttonColor
                                      : greyColor),
                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25,)),
                                ),
                                child: const Text("Log in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}
