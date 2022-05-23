import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/forgot_password_view.dart';
import 'package:loan_application_system/view/widgets/auth_base_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _hintTextEmail = "example@test.com";
  String _hintTextPassword = "case-sensitive";


  late FocusNode myFocusNodeEmail;
  late FocusNode myFocusNodePassword;

  @override
  initState() {
    super.initState();
    myFocusNodeEmail = FocusNode();
    myFocusNodePassword = FocusNode();

    myFocusNodeEmail.addListener(() {
      if (myFocusNodeEmail.hasFocus) {
        _hintTextEmail = '';
      } else {
        _hintTextEmail = 'example@test.com';
      }
      setState(() {});
    });

    myFocusNodePassword.addListener(() {
      if (myFocusNodePassword.hasFocus) {
        _hintTextPassword = '';
      } else {
        _hintTextPassword = 'case-sensitive';
      }
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBaseView(
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
                const Text("Log in to your account", style: TextStyle(color: monochromeBlackColor, fontWeight: FontWeight.w700, fontSize: l),),
                const SizedBox(height: 60),

                const Text("Email Address", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w600),),
                TextFormField(
                  controller: _emailController,
                  focusNode: myFocusNodeEmail,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  onChanged: (value) {
                    setState((){});
                  },
                  decoration: InputDecoration(
                    hintText: _hintTextEmail,
                    hintStyle: const TextStyle(color: lightGreyColor, fontWeight: FontWeight.w600),
                    isDense: true,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: darkGreyColor)),
                    errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: pinkColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),

                const SizedBox(height: 30),

                const Text("Password", style: TextStyle(fontSize: s, color: darkGreyColor),),
                TextFormField(
                  controller: _passwordController,
                  focusNode: myFocusNodePassword,
                  onChanged: (value) {
                    setState((){});
                  },
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: _hintTextPassword,
                    hintStyle: const TextStyle(color: lightGreyColor, fontWeight: FontWeight.w600),
                    isDense: true,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: darkGreyColor)),
                    errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: pinkColor)),
                  ),
                ),

                const SizedBox(height: 60),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPasswordView()));
                      },
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
                            return Dialog(
                              backgroundColor: pinkColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              alignment: Alignment.bottomLeft,
                              insetPadding: const EdgeInsets.only(bottom: 60, left: 60),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: const Icon(Icons.close, color: pinkColor, size: 18,),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("Invalid email address or password.", style: TextStyle(color: Colors.white, fontSize: l, fontWeight: FontWeight.w700),),
                                        SizedBox(height: 10),
                                        Text("Click on ‘Forgot Login?' to reset your login details.", style: TextStyle(color: Colors.white, fontSize: m),),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close,
                                          color: Colors.white, size: 18),
                                    ),
                                  ],
                                ),
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
    );
  }
}
