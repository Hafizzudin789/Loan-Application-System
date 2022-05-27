import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/data.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/create_password_view.dart';
import 'package:loan_application_system/view/widgets/auth_base_view.dart';

import '../../utils/color_constant.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  String? _otpError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBaseView(
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
                      const Expanded(child: Text("Forgot Login?", style: TextStyle(color: blackColor, fontWeight: FontWeight.w600, fontSize: xxl,),),),
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
                      const Text("To recover your account, begin by entering your email address.", style: TextStyle(fontSize: m, color: blackColor, fontWeight: FontWeight.w500),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.08),

                      const Text("Email Address", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w500),),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        onChanged: (value) {
                          setState((){});
                        },
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "An email is required";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          if(value != Data.emailId) {
                            return "Something wrong, You must contact your administrator to reset your password.";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "example@test.com",
                          hintStyle: TextStyle(color: greyColor, fontWeight: FontWeight.w600),
                          isDense: true,
                          errorStyle: TextStyle(color: errorColor),
                          errorMaxLines: 2,
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkGreyColor)),
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: errorColor)),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.15),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    content: StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/closeIcon.svg",
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Image.asset("assets/icon.png", scale: 1.3,),
                                              const SizedBox(height: 20),

                                              const Text("Almost there, enter 6-digit OTP", style: TextStyle(fontSize: xl, fontWeight: FontWeight.w600, color: blackColor),),
                                              const SizedBox(height: 10),
                                              const Text("Please enter the verification code sent to your email", style: TextStyle(fontSize: m, fontWeight: FontWeight.w500, color: darkGreyColor),),
                                              const SizedBox(height: 5),
                                              const Text("digibanc@gmail.com", style: TextStyle(color: primaryColor, fontSize: m, fontWeight: FontWeight.w500,),),
                                              const SizedBox(height: 30),
                                              TextField(
                                                controller: _otpController,
                                                obscureText: true,
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6),],
                                                decoration: InputDecoration(
                                                  hintText: "Enter 6-digit code",
                                                  hintStyle: const TextStyle(color: greyColor, fontWeight: FontWeight.w600, fontSize: xl),
                                                  border: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor,),),
                                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor,),),
                                                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor,),),
                                                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: errorColor,),),
                                                  errorText: _otpError,
                                                  errorStyle: const TextStyle(color: errorColor),
                                                ),
                                              ),

                                              const SizedBox(height: 30),

                                              Row(
                                                children: [
                                                  Expanded(child: Text(_otpController.text.length==6 ?"Resend code":"Resend code 04:57", style: TextStyle(fontSize: m, fontWeight: FontWeight.w600, color: _otpController.text.length==6 ?primaryColor:blackColor,),)),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(_otpController.text.length==6 ? primaryColor: idleGreyColor),
                                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),),
                                                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20),),
                                                    ),
                                                    onPressed: () {
                                                      if(_otpController.text == Data.otpCode) {
                                                        Navigator.pop(context);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreatePasswordView(),),);
                                                      } else {
                                                        setState((){
                                                          _otpError = "Incorrect verification code";
                                                        });
                                                      }
                                                    },
                                                    child: const Text("Verify email", style: TextStyle(color: Colors.white, fontSize: m, fontWeight: FontWeight.w700),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(_emailController.text.isNotEmpty
                                ? primaryColor
                                : idleGreyColor),
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
    );
  }


  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _otpController.dispose();
  }
}
