import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/view/profile_view/security_details_view.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:loan_application_system/view_model/profile_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../utils/font_size.dart';

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
          resizeToAvoidBottomInset: false,
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
                        : SecurityDetailsView(profileViewModel: profileViewModel),
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
                ? blackColorMono
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
                        color: blackColorMono,
                        fontSize: xxl,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      // viewModel.changeLayoutViewIndex(LayoutViewIndex.dashboardView);
                      Navigator.pop(context);
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
                                    profileViewModel.pickAndUpload(context);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(color: profileViewModel.profileImagePath != null?errorColor:borderGreyColor))),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    foregroundColor: MaterialStateProperty.all(profileViewModel.profileImagePath != null?errorColor:blackColorMono),
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
                                  color: blackColorMono),
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
                                  color: blackColorMono),
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
                                  color: blackColorMono),
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
                                  color: blackColorMono),
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
                                  color: blackColorMono),
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
                                  color: blackColorMono),
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
}

