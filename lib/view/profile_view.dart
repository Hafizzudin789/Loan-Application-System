import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:loan_application_system/view_model/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import '../utils/font_size.dart';
import 'auth_view/login_view.dart';

class ProfileView extends ViewModelWidget<LayoutViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onDispose: (profileViewModel) {
        profileViewModel.disposeResource();
      },
      builder: (context, profileViewModel, _) {
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
                                SvgPicture.asset("assets/profileIcon.svg", color: Colors.white,),
                                const SizedBox(width: 10),
                                const Expanded(child: Text("ACCOUNT SETTINGS", style: TextStyle(color: Colors.white, fontSize: s, fontWeight: FontWeight.w700, letterSpacing: 1.5,),)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _menuButton("Profile Details", ProfileViewState.profile, profileViewModel),
                                  _menuButton("Security Details", ProfileViewState.security, profileViewModel),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: profileViewModel.profileViewState == ProfileViewState.profile
                        ? _profileDetailWidget(profileViewModel, viewModel)
                        : _securityDetailWidget(profileViewModel, viewModel),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menuButton(String label, ProfileViewState profileViewState, ProfileViewModel profileViewModel) {
    return InkWell(
      onTap: () {
        profileViewModel.changeState(profileViewState);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: profileViewState == profileViewModel.profileViewState
              ? Colors.white
              : Colors.transparent,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100), topLeft: Radius.circular(100)),
        ),
        child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: m,
            color: profileViewState == profileViewModel.profileViewState
                ? blackColor
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _profileDetailWidget(ProfileViewModel profileViewModel, LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile Details",
                    style: TextStyle(
                        color: blackColor,
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
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                    MediaQuery.of(context).size.width * 0.4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                          "Please contact your administrator to edit the details below."),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: lightGreyColor,
                            border: Border.all(color: primaryGrey)),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Profile Picture",
                              style: TextStyle(
                                color: secondaryDarkGrey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: profileViewModel.profileImagePath == null
                                    ? Container(
                                        height: 70,
                                        width: 70,
                                        color: secondaryDarkGrey,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "PD",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: xxl,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    : Image.file(File(profileViewModel.profileImagePath!), fit: BoxFit.cover, height: 70, width: 70,),
                              ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    profileViewModel.pickAndUpload();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(color: profileViewModel.profileImagePath != null?errorColor:borderGreyColor))),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(profileViewModel.profileImagePath != null?errorColor:blackColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        profileViewModel.profileImagePath != null?"Remove Picture":"Upload Picture",
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.w700),
                                      ),
                                      const SizedBox(width: 10),
                                      profileViewModel.profileImagePath != null
                                          ? const Icon(Icons.delete_outlined)
                                          : SvgPicture.asset("assets/uploadIcon.svg"),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: profileViewModel.firstNameTEC,
                              enabled: false,
                              style: const TextStyle(
                                  color: blackColor),
                              decoration: const InputDecoration(
                                labelText: "First Name",
                                disabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderGreyColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: profileViewModel.lastNameTEC,
                              enabled: false,
                              style: const TextStyle(
                                  color: blackColor),
                              //style: const TextStyle(fontSize: 14, color: blackColor, fontWeight: FontWeight.w700),
                              decoration: const InputDecoration(
                                labelText: "Last Name",
                                disabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderGreyColor),
                                ),
                                // labelStyle: TextStyle(fontSize: 12, color: darkGreyColor, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: profileViewModel.emailTEC,
                              style: const TextStyle(
                                  color: blackColor),
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                disabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderGreyColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: profileViewModel.birthDateTEC,
                              style: const TextStyle(
                                  color: blackColor),
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: "Date of birth",
                                disabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderGreyColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: profileViewModel.statusTEC,
                              style: const TextStyle(
                                  color: blackColor),
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: "Status",
                                disabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderGreyColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: profileViewModel.joinDateTEC,
                              style: const TextStyle(
                                  color: blackColor),
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: "Date joining",
                                disabledBorder:
                                UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderGreyColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _securityDetailWidget(ProfileViewModel profileViewModel, LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
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
                        color: blackColor,
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
              child: SingleChildScrollView(
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
                        const Text("Change your password", style: TextStyle(fontWeight: FontWeight.w700, color: blackColor),),
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
                                    style: const TextStyle(color: blackColor),
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
                                    style: const TextStyle(color: blackColor),
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
                                              const Expanded(child: Text("Re-enter password", style: TextStyle(fontSize: xxl, color: blackColor, fontWeight: FontWeight.w700),)),
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
                                                                      color: blackColor,
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
                                                              const Text("Your password reset is successful.", style: TextStyle(fontSize: xl, color: blackColor, fontWeight: FontWeight.w600),),
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
                              foregroundColor: MaterialStateProperty.all(blackColor),
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
            ),
          ],
        );
      }
    );
  }
}

