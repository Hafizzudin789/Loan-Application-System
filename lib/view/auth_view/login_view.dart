import 'package:flutter/material.dart';
import 'package:loan_application_system/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/forgot_password_view.dart';
import 'package:loan_application_system/view/auth_view/auth_base_view.dart';
import 'package:loan_application_system/view/layout_view/layout_view.dart';

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

  bool obscurePassValue = true;
  bool _hasError = false;

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

    _emailController.dispose();
    _passwordController.dispose();

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
                const Text("Log in to your account", style: TextStyle(color: blackColorMono, fontWeight: FontWeight.w700, fontSize: xl),),
                const SizedBox(height: 60),

                const Text("Email Address", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w600),),
                TextFormField(
                  controller: _emailController,
                  focusNode: myFocusNodeEmail,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  onChanged: (value) {
                    setState((){});
                  },
                  decoration: InputDecoration(
                    hintText: _hintTextEmail,
                    hintStyle: const TextStyle(color: greyColor, fontWeight: FontWeight.w600),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _hasError?errorColor:idleGreyColor)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: darkGreyColor)),
                    errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: errorColor)),
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
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  obscureText: obscurePassValue,
                  decoration: InputDecoration(
                    hintText: _hintTextPassword,
                    hintStyle: const TextStyle(color: greyColor, fontWeight: FontWeight.w600),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _hasError?errorColor:idleGreyColor)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: darkGreyColor)),
                    errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: errorColor)),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          obscurePassValue = !obscurePassValue;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 18,
                      ),
                    ),
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
                      onPressed: !_emailController.text.isNotEmpty && !_passwordController.text.isNotEmpty? null: () {
                        if(_formKey.currentState!.validate()) {
                          setState((){
                            _hasError = false;
                          });
                          if(_emailController.text == Data.emailId && _passwordController.text == Data.password) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LayoutView()));
                          } else {
                            setState((){
                              _hasError = true;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: errorColor,
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
                                            child: const Icon(Icons.close, color: errorColor, size: 18,),
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
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty
                            ? primaryColor
                            : idleGreyColor),
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
