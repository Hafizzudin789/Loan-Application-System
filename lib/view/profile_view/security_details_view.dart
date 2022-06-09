import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/login_view.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:loan_application_system/view_model/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class SecurityDetailsView extends ViewModelWidget<LayoutViewModel> {
  final ProfileViewModel profileViewModel;
  const SecurityDetailsView({Key? key, required this.profileViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Security Details",
                style: TextStyle(
                    color: blackColorMono,
                    fontSize: xxl,
                    fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () {
                  viewModel.changeLayoutViewIndex(LayoutViewIndex.dashboardView);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    "assets/closeIcon.svg",
                    width: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              maxWidth:
              MediaQuery.of(context).size.width * 0.4,
            ),
            child: Form(
              key: profileViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text("Change your password", style: TextStyle(fontWeight: FontWeight.w700, color: blackColorMono),),
                  const SizedBox(height: 10),
                  const Text("Lorem ipsum dolor sit amet, contetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),

                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Current Password", style: TextStyle(fontSize: s, fontWeight: FontWeight.w600),),
                            TextFormField(
                              obscureText: true,
                              controller: profileViewModel.passwordTEC,
                              style: const TextStyle(color: blackColorMono),
                              onChanged: (value) {
                                profileViewModel.updateState();
                              },
                              decoration: const InputDecoration(
                                hintText: "Please enter",
                                hintStyle: TextStyle(fontWeight: FontWeight.w700, color: greyColor, letterSpacing: 0.2),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                              ),
                              validator: (value) {
                                if(value==null || value.isEmpty){
                                  return "This field can't be empty";
                                }
                                if(value!= Data.password) {
                                  return "Incorrect password";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("New Password", style: TextStyle(fontSize: s, fontWeight: FontWeight.w600),),
                            TextFormField(
                              controller: profileViewModel.confirmPasswordTEC,
                              obscureText: true,
                              style: const TextStyle(color: blackColorMono),
                              onChanged: (value) {
                                profileViewModel.updateState();
                              },
                              decoration: const InputDecoration(
                                hintText: "Please enter",
                                hintStyle: TextStyle(fontWeight: FontWeight.w700, color: greyColor, letterSpacing: 0.2),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                              ),
                              validator: (value) {
                                if(value==null || value.isEmpty){
                                  return "This field can't be empty";
                                }
                                if(value.length<8){
                                  return "Password should have 8 or more characters.";
                                }
                                if(!RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])").hasMatch(value)) {
                                  return "Password should contain Capital, Small letter, & number";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: profileViewModel.passwordTEC.text.isNotEmpty && profileViewModel.confirmPasswordTEC.text.isNotEmpty?() {
                        if (profileViewModel.formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                    title: Row(
                                      children: [
                                        const Expanded(child: Text("Re-enter password", style: TextStyle(fontSize: xxl, color: blackColorMono, fontWeight: FontWeight.w700),)),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: SvgPicture.asset("assets/closeIcon.svg"),
                                        ),
                                      ],
                                    ),
                                    content: Form(
                                      key: profileViewModel.reenterFormKey,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: TextFormField(
                                          obscureText: true,
                                          controller: profileViewModel.reenterPasswordTEC,
                                          onChanged: (value) {
                                            setState((){});
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "Please enter",
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                          ),
                                          validator: (value) {
                                            if(value != profileViewModel.confirmPasswordTEC.text) {
                                              return "Password didn't match";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          if(profileViewModel.reenterFormKey.currentState!.validate()) {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return AlertDialog  (
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                                                  content: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment.centerRight,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(10),
                                                              child: SvgPicture.asset(
                                                                "assets/closeIcon.svg",
                                                                color: blackColorMono,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.all(15),
                                                          decoration: const BoxDecoration(
                                                            color: successColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.done_rounded, color: Colors.white,),
                                                        ),
                                                        const SizedBox(height: 20),
                                                        const Text("Your password reset is successful.", style: TextStyle(fontSize: xl, color: blackColorMono, fontWeight: FontWeight.w600),),
                                                        const SizedBox(height: 6),
                                                        const Text("Please login with your new password.", style: TextStyle(color: darkGreyColor, fontSize: m),),

                                                        const SizedBox(height: 30),

                                                        ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all(primaryColor),
                                                            foregroundColor: MaterialStateProperty.all(Colors.white),
                                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),),
                                                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20),),
                                                          ),
                                                          onPressed: () {
                                                            viewModel.justChangeLayoutViewIndex(LayoutViewIndex.dashboardView);
                                                            profileViewModel.justChangeState(ProfileViewState.profile);
                                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginView()), (route) => false);
                                                          },
                                                          child: const Text("Back to Log in", style: TextStyle(fontSize: m, fontWeight: FontWeight.w700),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(profileViewModel.reenterPasswordTEC.text.isNotEmpty?primaryColor:idleGreyColor),
                                          foregroundColor: MaterialStateProperty.all(Colors.white),
                                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                        ),
                                        child: const Text("Confirm"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        }
                      }: null,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                        backgroundColor: MaterialStateProperty.all(profileViewModel.passwordTEC.text.isNotEmpty && profileViewModel.confirmPasswordTEC.text.isNotEmpty
                            ? primaryColor
                            : idleGreyColor
                        ),
                        foregroundColor: MaterialStateProperty.all(blackColorMono),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20)),
                      ),
                      child: const Text(
                        "Update Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
