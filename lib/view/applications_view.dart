import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/custom_app_bar.dart';
import 'package:loan_application_system/view/widgets/footer.dart';

class ApplicationsView extends StatefulWidget {
  const ApplicationsView({Key? key}) : super(key: key);

  @override
  State<ApplicationsView> createState() => _ApplicationsViewState();
}

class _ApplicationsViewState extends State<ApplicationsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 0),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              children: [
                _navButtonsWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingTextStyle: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w400, fontSize: s+1),
                        columns: const [
                          DataColumn(label: Text("Applicant Name")),
                          DataColumn(label: Text("Finance Amount")),
                          DataColumn(label: Text("Applicant Email")),
                          DataColumn(label: Text("Product")),
                          DataColumn(label: Text("Type")),
                          DataColumn(label: Text("Application ID")),
                          DataColumn(label: Text("CIF No.")),
                          DataColumn(label: Text("Created Date")),
                          DataColumn(label: Text("Mobile Number")),
                          DataColumn(label: Text("Status")),
                        ],
                        rows: Data.customerApplications.map((e) => DataRow(
                          cells: [
                            DataCell(Text(e.applicantName, style: const TextStyle(color: blackColorMono, fontWeight: FontWeight.w700, fontSize: m),)),
                            DataCell(Text(e.financeAmount.toString(), style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(Text(e.applicantEmail, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500,fontSize: m),)),
                            DataCell(Text(e.product, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(Text(e.type, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(Text(e.applicationId, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(Text(e.cifNo, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(Text(e.createdDate, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(Text(e.mobileNumber, style: const TextStyle(color: darkGreyColor, fontWeight: FontWeight.w500, fontSize: m),)),
                            DataCell(
                              Row(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: e.status == CustomerApplicationStatus.newA
                                          ? const Color(0XFF0590FF)
                                          : e.status == CustomerApplicationStatus.processing
                                            ? yellowColor
                                            : e.status == CustomerApplicationStatus.complete
                                              ? greenColor
                                              : e.status == CustomerApplicationStatus.accepted
                                                ? const Color(0XFF5CD2D0)
                                                : e.status == CustomerApplicationStatus.delivery
                                                  ? orangeColor
                                                  : warningColor,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          e.status.label,
                                          style: TextStyle(
                                            color: e.status == CustomerApplicationStatus.newA || e.status == CustomerApplicationStatus.declined
                                                ? Colors.white
                                                : blackColorMono,
                                            fontWeight: FontWeight.w700,
                                            fontSize: s,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(Icons.info_outline_rounded, size: 15, color: e.status == CustomerApplicationStatus.newA || e.status == CustomerApplicationStatus.declined
                                            ? Colors.white
                                            : blackColorMono,)
                                      ],
                                    ),
                                  ),
                                  const Expanded(child: SizedBox(width: 20)),
                                  const Icon(Icons.more_vert)
                                ],
                              ),
                            ),
                          ],
                        ),).toList(),
                      ),
                    ),
                  ),
                ),
                const Divider(color: borderGreyColor, height: 0, thickness: 1,),
                const SizedBox(height: 5),
                _tableFooter(),
              ],
            ),
          ),
        ),
        const Footer(),
      ],
    );
  }

  Widget _navButtonsWidget() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: borderGreyColor))),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(blackColorMono),
          ),
          child: Row(
            children: const [
              Text(
                "All Product",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
              )
            ],
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: borderGreyColor))),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(blackColorMono),
          ),
          child: Row(
            children: const [
              Text(
                "All Status",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
              )
            ],
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: borderGreyColor))),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(blackColorMono),
          ),
          child: Row(
            children: [
              const Text(
                "Filters",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset("assets/filterIcon.svg")
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        const SizedBox(
          width: 200,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: borderGreyColor))),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(blackColorMono),
          ),
          child: Row(
            children: [
              const Text(
                "Download",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset("assets/downloadIcon.svg")
            ],
          ),
        ),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       backgroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              //       contentPadding: EdgeInsets.zero,
              //       content: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           const SizedBox(height: 10),
              //           Padding(
              //             padding: const EdgeInsets.all(24.0),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 const Expanded(child: Text("Which one would you like to create?", style: TextStyle(color: blackColorMono, fontSize: xxl, fontWeight: FontWeight.w700),)),
              //                 const SizedBox(width: 10),
              //                 InkWell(
              //                   onTap: () {
              //                     Navigator.pop(context);
              //                   },
              //                   child: const Icon(Icons.close,
              //                       color: blackColorMono, size: 30),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const Divider(height: 0),
              //           Padding(
              //             padding: const EdgeInsets.all(24.0),
              //             child: Row(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 _cardTypeWidget("Credit Card", "assets/discountIcon.svg", const Color(0XFF5CD2D0), const Color(0XFF5CD2D0).withOpacity(0.1), _showCardOptionsDetail, viewModel),
              //                 const SizedBox(width: 15),
              //                 _cardTypeWidget("Auto Finance", "assets/carIcon.svg", yellowColor, const Color(0XFFFFFBED), _showFinanceDetail, viewModel),
              //                 const SizedBox(width: 15),
              //                 _cardTypeWidget("Personal Finance", "assets/financeIcon.svg", const Color(0XFF0590FF), const Color(0XFF0590FF).withOpacity(0.1), _showPersonalFinanceDetail, viewModel),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // );
            },
            tooltip: "Request application",
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tableFooter() {
    return Row(
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(color: borderGreyColor, width: 1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: idleGreyColor,),
        ),
        const SizedBox(width: 8),
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(color: borderGreyColor, width: 1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text("1", style: TextStyle(fontWeight: FontWeight.w700, color: blackColorMono),),
        ),
        const SizedBox(width: 8),
        Container(
          height: 34,
          width: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: lightGreyColor,
          ),
          alignment: Alignment.center,
          child: const Text("2", style: TextStyle(fontWeight: FontWeight.w700),),
        ),
        const SizedBox(width: 8),
        Container(
          height: 34,
          width: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: lightGreyColor,
          ),
          alignment: Alignment.center,
          child: const Text("3", style: TextStyle(fontWeight: FontWeight.w700),),
        ),
        const SizedBox(width: 8),
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(color: borderGreyColor, width: 1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_forward_ios_rounded, size: 20,),
        ),
        const Expanded(child: SizedBox()),
        const Text("Showing 1 - 10 of 56", style: TextStyle(color: darkGreyColor, fontSize: s-1, fontWeight: FontWeight.w600),),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: borderGreyColor))),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(blackColorMono),
          ),
          child: Row(
            children: const [
              Text(
                "1",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
              )
            ],
          ),
        ),
      ],
    );
  }
}
