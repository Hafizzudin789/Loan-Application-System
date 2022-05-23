import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/login_view.dart';
import 'package:loan_application_system/view/widgets/auth_base_view.dart';

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({Key? key}) : super(key: key);

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBaseView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      const Expanded(child: Text("Create new password", style: TextStyle(color: monochromeBlackColor, fontWeight: FontWeight.w600, fontSize: xxl),)),
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
                      const Text("Please enter your new password and make sure minimum of "
                          "8 characters with combination of at least 1 uppercase, "
                          "1 lowercase and 1 digit"),

                      const SizedBox(height: 30),

                      const Text("Password", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w500),),
                      TextFormField(
                        controller: _passwordController,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        obscureText: true,
                        onChanged: (value) {
                          setState((){});
                        },
                        decoration: InputDecoration(
                          hintText: "example@test.com",
                          hintStyle: const TextStyle(color: lightGreyColor, fontWeight: FontWeight.w700),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _passwordController.text.isNotEmpty?pinkColor:greyColor)),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: pinkColor)),
                          suffixIcon: const InkWell(child: Icon(Icons.remove_red_eye_outlined)),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text("Re-enter Password", style: TextStyle(fontSize: s, color: darkGreyColor),),
                      TextFormField(
                        controller: _confirmPasswordController,
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
                          suffixIcon: const InkWell(child: Icon(Icons.remove_red_eye_outlined)),
                        ),
                      ),

                      const SizedBox(height: 60),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(alignment: Alignment.centerRight,child: SvgPicture.asset("assets/closeIcon.svg", color: monochromeBlackColor,)),
                                      const SizedBox(height: 20),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: const BoxDecoration(
                                          color: greenColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.done_rounded, color: Colors.white,),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text("Your password reset is successful.", style: TextStyle(fontSize: xl, color: monochromeBlackColor),),
                                      const SizedBox(height: 10),
                                      const Text("Please login with your new password.", style: TextStyle(color: darkGreyColor, fontSize: m),),

                                      const SizedBox(height: 30),

                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(buttonColor),
                                          foregroundColor: MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),),
                                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20),),
                                        ),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginView()), (route) => false);
                                        },
                                        child: const Text("Back to Log in", style: TextStyle(fontSize: m),),
                                      ),
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
                            backgroundColor: MaterialStateProperty.all(_passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty
                                ? buttonColor
                                : greyColor),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25,)),
                          ),
                          child: const Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
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
    );
  }
}
