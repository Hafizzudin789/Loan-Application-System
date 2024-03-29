import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/date_format.dart';
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
      onModelReady: (applicationsViewModel)=>applicationsViewModel.initializeApplicationsList(),
      onDispose: (applicationsViewModel) => applicationsViewModel.disposeResource(),
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
                      child: applicationsViewModel.customerApplications.isEmpty
                          ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                              SvgPicture.asset("assets/search.svg"),
                              const SizedBox(height: 10),
                              const Text("Sorry, no result found", style: TextStyle(color: noResultColor, fontSize: l, fontWeight: FontWeight.w700),),
                              const SizedBox(height: 5),
                              const Text("Your search was unfortunately not found or does’t exist.", style: TextStyle(color: darkGreyColor),),
                            ],
                          )
                          : SingleChildScrollView(
                              child: Row(
                                children: [
                                  Expanded(
                                    child:SingleChildScrollView(
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
                                                        // DateFormat.yMd().format(DateTime.parse(e.createdDate)),
                                                        formatDate(DateTime.parse(e.createdDate)),
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
                                                ).toList(),
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
                                    ])).toList(),
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
          offset: const Offset(0, 40),
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
          offset: const Offset(0, 40),
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

        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          offset: const Offset(0, 40),
          itemBuilder: (context) => applicationsViewModel.customFilterList.map(
                (e) => PopupMenuItem<String>(
                  enabled: false,
                  child: e == "Reset Filter"
                      ? InkWell(
                          onTap: () {
                            applicationsViewModel.resetFilters();
                          },
                          child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: applicationsViewModel.dateOrAmountFilterApplied? primaryColor: idleGreyColor,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        )
                      : PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          offset: const Offset(250, 0),
                          constraints: const BoxConstraints(
                            minWidth: 250,
                            maxWidth: 250,
                          ),
                          itemBuilder: (context) => [
                            e == "Date"
                                ? PopupMenuItem(
                                    enabled: false,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const Text("Select a date range", style: TextStyle(fontSize: s, color: secondaryDarkGrey, fontWeight: FontWeight.w700),),
                                        const SizedBox(height: 6),
                                        const Text("From", style: TextStyle(fontSize: s, color: darkGreyColor),),
                                        TextField(
                                          controller: applicationsViewModel.fromTEC,
                                          readOnly: true,
                                          onTap: () {
                                            applicationsViewModel.selectDate(context, applicationsViewModel.fromTEC, true);
                                          },
                                          style: const TextStyle(color: blackColorMono),
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(Icons.date_range_rounded, color: blackColorMono,),
                                            isDense: true,
                                            hintText: "dd mm yyyy",
                                            hintStyle: TextStyle(fontWeight: FontWeight.w700, color: greyColor),
                                            border: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text("To", style: TextStyle(fontSize: s, color: darkGreyColor),),
                                        TextField(
                                          controller: applicationsViewModel.toTEC,
                                          readOnly: true,
                                          onTap: () {
                                            applicationsViewModel.selectDate(context, applicationsViewModel.toTEC, false);
                                          },
                                          style: const TextStyle(color: blackColorMono),
                                          decoration: const InputDecoration(
                                            suffixIcon: Icon(Icons.date_range_rounded, color: blackColorMono,),
                                            isDense: true,
                                            hintText: "dd mm yyyy",
                                            hintStyle: TextStyle(fontWeight: FontWeight.w700, color: greyColor),
                                            border: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextButton(
                                          onPressed: () {
                                            applicationsViewModel.applyDateFilter();
                                          },
                                          style: ButtonStyle(
                                            //backgroundColor: MaterialStateProperty.all(applicationsViewModel.fromTEC.text.isNotEmpty && applicationsViewModel.toTEC.text.isNotEmpty?primaryColor: idleGreyColor),
                                            backgroundColor: MaterialStateProperty.all(primaryColor),
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                            foregroundColor: MaterialStateProperty.all(Colors.white),
                                          ),
                                          child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.w700),),
                                        ),
                                      ],
                                    ),
                                  )
                                : PopupMenuItem(
                                    enabled: false,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const Text("Select a amount range", style: TextStyle(fontSize: s, color: secondaryDarkGrey, fontWeight: FontWeight.w700),),
                                            const SizedBox(height: 4),
                                            const Text("Minimum amount", style: TextStyle(fontSize: s, color: darkGreyColor, fontWeight: FontWeight.w500),),
                                            TextField(
                                              controller: applicationsViewModel.minAmountTEC,
                                              keyboardType: TextInputType.number,
                                              style: const TextStyle(fontWeight: FontWeight.w700),
                                              onTap: () {
                                                if(applicationsViewModel.minAmountTEC.text.isEmpty) {
                                                  setState(() {
                                                    applicationsViewModel.minAmountTEC.text = "BHD ";
                                                    applicationsViewModel.minAmountTEC.selection = TextSelection.fromPosition(TextPosition(offset: applicationsViewModel.minAmountTEC.text.length));
                                                  });
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                hintText: "BHD 0.00",
                                                hintStyle: TextStyle(fontWeight: FontWeight.w700, color: greyColor),
                                                border: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text("Max amount", style: TextStyle(fontSize: s, color: darkGreyColor),),
                                            TextField(
                                              controller: applicationsViewModel.maxAmountTEC,
                                              keyboardType: TextInputType.number,
                                              style: const TextStyle(fontWeight: FontWeight.w700),
                                              onTap: () {
                                                if(applicationsViewModel.maxAmountTEC.text.isEmpty) {
                                                  setState(() {
                                                    applicationsViewModel.maxAmountTEC.text = "BHD ";
                                                    applicationsViewModel.maxAmountTEC.selection = TextSelection.fromPosition(TextPosition(offset: applicationsViewModel.maxAmountTEC.text.length));
                                                  });
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                hintText: "BHD 0.00",
                                                hintStyle: TextStyle(fontWeight: FontWeight.w700, color: greyColor),
                                                border: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextButton(
                                              onPressed: () {
                                                applicationsViewModel.applyAmountFilter();
                                              },
                                              style: ButtonStyle(
                                                //backgroundColor: MaterialStateProperty.all(applicationsViewModel.minAmountTEC.text.isNotEmpty && applicationsViewModel.maxAmountTEC.text.isNotEmpty?primaryColor: idleGreyColor),
                                                backgroundColor: MaterialStateProperty.all(primaryColor),
                                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                                foregroundColor: MaterialStateProperty.all(Colors.white),
                                              ),
                                              child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.w700),),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(e, style: const TextStyle(color: blackColorMono, fontWeight: FontWeight.w700),)),
                                    // const Icon(Icons.keyboard_arrow_right_rounded, color: blackColorMono,)
                                    SvgPicture.asset("assets/arrowForward.svg", color: blackColorMono, height: 12,)
                                  ],
                                ),
                                const SizedBox(height: 12),
                                applicationsViewModel.dateOrAmountFilterApplied && e == "Date" && applicationsViewModel.fromTEC.text.isNotEmpty && applicationsViewModel.toTEC.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () {
                                          applicationsViewModel.resetFilters();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: darkBlueColor,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text("${applicationsViewModel.fromTEC.text} - ${applicationsViewModel.toTEC.text}", style: const TextStyle(fontSize: s, color: Colors.white),)),
                                                SvgPicture.asset("assets/clearIcon.svg", color: Colors.white,),
                                              ],
                                            ),
                                          ),
                                      )
                                    : applicationsViewModel.dateOrAmountFilterApplied && e == "Amount" && applicationsViewModel.minAmountTEC.text.isNotEmpty && applicationsViewModel.maxAmountTEC.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            applicationsViewModel.resetFilters();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: darkBlueColor,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text("${applicationsViewModel.minAmountTEC.text} - ${applicationsViewModel.maxAmountTEC.text}", style: const TextStyle(fontSize: s, color: Colors.white),)),
                                                SvgPicture.asset("assets/clearIcon.svg", color: Colors.white,),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                ),
          ).toList(),
          child: ElevatedButtonWidget(text: "Filters", iconData: Icons.keyboard_arrow_down_rounded, imagePath: applicationsViewModel.dateOrAmountFilterApplied?"assets/filterApplied.svg": "assets/filterIcon.svg"),
        ),

        const Expanded(child: SizedBox()),
        TextField(
          controller: applicationsViewModel.searchTEC,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            applicationsViewModel.searchCustomerApplications();
          },
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: greyColor, fontWeight: FontWeight.w700),
            suffixIcon: InkWell(
              onTap: () {
                applicationsViewModel.searchTEC.clear();
                applicationsViewModel.updateUI();
              },
              child: applicationsViewModel.searchTEC.text.isNotEmpty
                  ? SvgPicture.asset("assets/clearIcon.svg", height: 5, width: 5)
                  : Icon(applicationsViewModel.searchTEC.text.isNotEmpty?Icons.close:Icons.search, color: blackColorMono, size: 20,),
            ),
            suffixIconConstraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
            ),
            constraints: const BoxConstraints(
              minWidth: 150,
              maxWidth: 200,
            ),
            border: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: idleGreyColor)),
          ),
          onChanged: (value) {
            applicationsViewModel.updateUI();
          },
        ),
        const SizedBox(width: 15),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: borderGreyColor, width: 1)
          ),
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {},
            tooltip: "Request application",
            icon: SvgPicture.asset("assets/downloadIcon.svg", color: blackColorMono,),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            showApplyApplicationsPopUp(context, viewModel);
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),)),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 15))
          ),
          child: Row(
            children: const [
              Text(
                "New Application",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.add,
                color: Colors.white,
              ),
            ],
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
        applicationsViewModel.pageNumber == 1 && applicationsViewModel.customerApplications.length == Data.customerApplications.length
            ? const SizedBox()
            : _pageNumberWidget(applicationsViewModel, 2),
        const SizedBox(width: 8),
        applicationsViewModel.pageNumber == 1 && applicationsViewModel.customerApplications.length == Data.customerApplications.length
            ? const SizedBox()
            : _pageNumberWidget(applicationsViewModel, 3),
        const SizedBox(width: 8),
       InkWell(
          onTap:  applicationsViewModel.pageNumber == 1 && applicationsViewModel.customerApplications.length == Data.customerApplications.length
              ? null
              : () {
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
            child: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: (applicationsViewModel.pageNumber != 3)
                ? blackColorMono
                : idleGreyColor,
            ),
          ),
        ),

        const Expanded(child: SizedBox()),
        Text(
          applicationsViewModel.pageNumber==1
              ? "Showing 1 - ${applicationsViewModel.customerApplications.length} of ${Data.customerApplications.length}"
              : applicationsViewModel.pageNumber==2
                  ? "Showing 11 - ${10+applicationsViewModel.customerApplications.length}  of ${Data.customerApplications.length}"
                  : "Showing 21 - ${20+applicationsViewModel.customerApplications.length}  of ${Data.customerApplications.length}",
          style: const TextStyle(
            color: darkGreyColor,
            fontSize: s - 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<ResultLimit>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          itemBuilder: (context) => applicationsViewModel.resultLimitList.map(
                (e) => PopupMenuItem<ResultLimit>(
                  value: e,
                  child: Text(e.value.toString()),
              ),
          ).toList(),
          onSelected: (ResultLimit value) {
            applicationsViewModel.changeResultLimit(value);
          },
          child: ElevatedButtonWidget(text: applicationsViewModel.resultLimit.value.toString(), iconData: Icons.keyboard_arrow_down_rounded),
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

