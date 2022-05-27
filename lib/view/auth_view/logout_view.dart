import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/auth_view/login_view.dart';
import 'package:loan_application_system/view/widgets/auth_base_view.dart';

class LogoutView extends StatefulWidget {
  final bool isSessionExpired;
  const LogoutView({Key? key, this.isSessionExpired = false}) : super(key: key);

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBaseView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          margin: const EdgeInsets.all(40),
          constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width * 0.7, double.infinity),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(10, 14, 49, 81), blurRadius: 10, spreadRadius: 0.1)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.done_rounded, color: Colors.white,),
              ),
              const SizedBox(height: 20,),
              Text(
                widget.isSessionExpired
                    ? "You session has expired! Your browser was idle for more than 20 minutes. Please log in again to continue"
                    : "You have successfully logged out!",
                style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: xl),
              ),
              const Text("Logged out on Tuesday, 21 Jan 22 at 13 : 36 PM"),
              const SizedBox(height: 30,),
              DataTable(
                headingTextStyle: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
                columns: const [
                  DataColumn(label: Text("Activity Details")),
                  DataColumn(label: Text("Ref No.")),
                  DataColumn(label: Text("Time")),
                  DataColumn(label: Text("Date")),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text("Lorem Ipsum sit dolor amet", style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: m),)),
                      DataCell(Text("3434353535", style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),)),
                      DataCell(Text("13 : 30 ", style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),)),
                      DataCell(Text("21 Jan 22", style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),)),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("Lorem Ipsum sit dolor amet", style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: m),)),
                      DataCell(Text("3434353535", style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),)),
                      DataCell(Text("13 : 30 ", style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),)),
                      DataCell(Text("21 Jan 22", style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 100,),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20))
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginView()), (route) => false);
                },
                child: const Text("Back to Log in", style: TextStyle(fontWeight: FontWeight.w700),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
