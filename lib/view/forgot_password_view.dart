import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/create_password_view.dart';
import 'package:loan_application_system/view/widgets/auth_base_view.dart';
import 'package:loan_application_system/view/widgets/footer.dart';

import '../utils/color_constant.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBaseView(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(40),
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              children: [
                                const Expanded(child: Text("Forgot Login?", style: TextStyle(color: monochromeBlackColor, fontWeight: FontWeight.w600, fontSize: xxl),)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset("assets/closeIcon.svg"),
                                ),
                              ],
                            ),
                          ),

                          const Divider(),

                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("To recover your account, begin by entering your email address.", style: TextStyle(fontSize: m, color: monochromeBlackColor, fontWeight: FontWeight.w500),),
                                SizedBox(height: MediaQuery.of(context).size.height*0.08),

                                const Text("Email Address", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w500),),
                                TextFormField(
                                  controller: _emailController,
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                  onChanged: (value) {
                                    setState((){});
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "example@test.com",
                                    hintStyle: TextStyle(color: lightGreyColor, fontWeight: FontWeight.w700),
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
                                  ),
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height*0.15),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset("assets/icon.svg", color: Colors.red,),
                                                const SizedBox(height: 20),

                                                Text("Almost there, enter 6-digit OTP"),
                                                const SizedBox(height: 10),
                                                Text("Please enter the verification code sent to your email"),
                                                const SizedBox(height: 5),
                                                Text("dian@digibanc.com"),
                                                const SizedBox(height: 30),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    hintText: "Enter 6-digit code",
                                                  ),
                                                ),

                                                const SizedBox(height: 30),

                                                Row(
                                                  children: [
                                                    Expanded(child: const Text("Resend code 04:57")),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all(greyColor),
                                                        foregroundColor: MaterialStateProperty.all(Colors.white),
                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),),
                                                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20),),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreatePasswordView(),),);
                                                      },
                                                      child:
                                                          Text("Verify email"),
                                                    ),
                                                  ],
                                                )

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
                                      backgroundColor: MaterialStateProperty.all(_emailController.text.isNotEmpty
                                          ? buttonColor
                                          : greyColor),
                                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25,)),
                                    ),
                                    child: const Text("Next", style : TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
                                  ),
                                ),
                              ],
                            ),
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
