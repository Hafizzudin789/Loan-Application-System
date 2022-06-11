import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/apply_applications_widget.dart';
import 'package:loan_application_system/view/widgets/custom_app_bar.dart';
import 'package:loan_application_system/view/widgets/elevated_button_widget.dart';
import 'package:loan_application_system/view/widgets/footer.dart';
import 'package:loan_application_system/view_model/applications_view_model.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';

class ApplicationsView extends ViewModelWidget<LayoutViewModel> {
  const ApplicationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return ViewModelBuilder<ApplicationsViewModel>.reactive(
      viewModelBuilder: () => ApplicationsViewModel(),
      builder: (context, applicationsViewModel, _) {
        return Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 15, bottom: 0),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    _navButtonsWidget(viewModel, applicationsViewModel, context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingTextStyle: const TextStyle(
                                    color: darkGreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: s + 1,
                                  ),
                                  showBottomBorder: true,
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
                                  ],
                                  rows: applicationsViewModel.customerApplications
                                      .map(
                                        (e) => DataRow(
                                          cells: [
                                            DataCell(Text(
                                              e.applicantName,
                                              style: const TextStyle(
                                                  color: blackColorMono,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.financeAmount.toString(),
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.applicantEmail,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.product.value,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.type,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.applicationId,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.cifNo,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.createdDate,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                            DataCell(Text(
                                              e.mobileNumber,
                                              style: const TextStyle(
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: m),
                                            )),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            DataTable(
                              headingTextStyle: const TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: s + 1),
                              decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: borderGreyColor, width: 1)),
                              ),
                              showBottomBorder: true,
                              columns: const [
                                DataColumn(label: Text("Status")),
                              ],
                              rows: applicationsViewModel.customerApplications
                                  .map((e) => DataRow(cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: e.status ==
                                                          CustomerApplicationStatus
                                                              .newA
                                                      ? const Color(0XFF0590FF)
                                                      : e.status ==
                                                              CustomerApplicationStatus
                                                                  .processing
                                                          ? yellowColor
                                                          : e.status ==
                                                                  CustomerApplicationStatus
                                                                      .complete
                                                              ? greenColor
                                                              : e.status ==
                                                                      CustomerApplicationStatus
                                                                          .accepted
                                                                  ? const Color(
                                                                      0XFF5CD2D0)
                                                                  : e.status ==
                                                                          CustomerApplicationStatus
                                                                              .delivery
                                                                      ? orangeColor
                                                                      : warningColor,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      e.status.label,
                                                      style: TextStyle(
                                                        color: e.status ==
                                                                    CustomerApplicationStatus
                                                                        .newA ||
                                                                e.status ==
                                                                    CustomerApplicationStatus
                                                                        .declined
                                                            ? Colors.white
                                                            : blackColorMono,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: s,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Icon(
                                                      Icons
                                                          .info_outline_rounded,
                                                      size: 15,
                                                      color: e.status ==
                                                                  CustomerApplicationStatus
                                                                      .newA ||
                                                              e.status ==
                                                                  CustomerApplicationStatus
                                                                      .declined
                                                          ? Colors.white
                                                          : blackColorMono,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox(width: 20)),
                                              const Icon(Icons.more_vert)
                                            ],
                                          ),
                                        ),
                                      ]))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),
                    _tableFooter(applicationsViewModel),
                  ],
                ),
              ),
            ),
            const Footer(),
          ],
        );
      },
    );
  }

  Widget _navButtonsWidget(LayoutViewModel viewModel, ApplicationsViewModel applicationsViewModel, BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<Product>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          itemBuilder: (context) => applicationsViewModel.products.map(
                (e) => PopupMenuItem<Product>(
                  value: e,
                  child: Text(e.value),
                ),
              ).toList(),
          onSelected: (Product value) {
            applicationsViewModel.selectProductType(value);
          },
          child: ElevatedButtonWidget(text: applicationsViewModel.productTypeSelected.value, iconData: Icons.keyboard_arrow_down_rounded),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<CustomerApplicationStatus>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          itemBuilder: (context) => applicationsViewModel.applicationStatusList.map((e) => PopupMenuItem<CustomerApplicationStatus>(
              value: e,
              child: Text(e.label),
            ),
          ).toList(),
          onSelected: (CustomerApplicationStatus value) {
            applicationsViewModel.selectApplicationStatus(value);
          },
          child: ElevatedButtonWidget(text: applicationsViewModel.applicationStatus.label, iconData: Icons.keyboard_arrow_down_rounded),
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
          width: 170,
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
              showApplyApplicationsPopUp(context, viewModel);
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

  Widget _tableFooter(ApplicationsViewModel applicationsViewModel) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if(applicationsViewModel.pageNumber != 1) {
              applicationsViewModel.changePage(applicationsViewModel.pageNumber-1);
            }
          },
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              border: Border.all(color: borderGreyColor, width: 1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: applicationsViewModel.pageNumber != 1? blackColorMono:idleGreyColor,),
          ),
        ),
        const SizedBox(width: 8),
        _pageNumberWidget(applicationsViewModel, 1),
        const SizedBox(width: 8),
        _pageNumberWidget(applicationsViewModel, 2),
        const SizedBox(width: 8),
        _pageNumberWidget(applicationsViewModel, 3),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            if(applicationsViewModel.pageNumber != 3) {
              applicationsViewModel.changePage(applicationsViewModel.pageNumber+1);
            }
          },
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              border: Border.all(color: borderGreyColor, width: 1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: applicationsViewModel.pageNumber != 3? blackColorMono:idleGreyColor,),
          ),
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

  Widget _pageNumberWidget(ApplicationsViewModel applicationsViewModel, int page) {
    return InkWell(
      onTap: () {
        applicationsViewModel.changePage(page);
      },
      child: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          border: Border.all(color: borderGreyColor, width: 1),
          shape: BoxShape.circle,
          color: applicationsViewModel.pageNumber== page?Colors.white:lightGreyColor,
        ),
        alignment: Alignment.center,
        child: Text(page.toString(), style: TextStyle(fontWeight: FontWeight.w700, color: applicationsViewModel.pageNumber== page? blackColorMono: darkGreyColor),),
      ),
    );
  }
}

