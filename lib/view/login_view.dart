import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/view/widgets/footer.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.all(40),
                    constraints: BoxConstraints.loose(
                      const Size(300, double.infinity)
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: const Color(0XFF0E3151).withOpacity(0.6), blurRadius: 20, spreadRadius: 0.1)
                      ],
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/appLogo.png", height: 32,),
                          const SizedBox(height: 10),
                          const Text("Log in to your account", style: TextStyle(color: monochromeColor, fontWeight: FontWeight.w500),),
                          const SizedBox(height: 30),

                          const Text("Email Address"),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "example@test.com",
                              isDense: true,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text("Password"),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "case-sensitive",
                              isDense: true,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: () {}, child: const Text("Forgot Login?", style: TextStyle(color: primaryColor),)),
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(const Color(0XFFCBD1D7),),
                                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20,))
                                ),
                                child: const Text("Log in", style: TextStyle(color: Colors.white,),),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
