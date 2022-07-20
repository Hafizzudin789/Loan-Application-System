import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view_model/customer_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProductDetailsView extends ViewModelWidget<CustomerProfileViewModel> {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, CustomerProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Product Details",
                  style: TextStyle(
                      color: blackColorMono,
                      fontSize: xxl,
                      fontWeight: FontWeight.w700),
                ),
              ),
              TextField(
                controller: viewModel.searchTEC,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  // applicationsViewModel.searchCustomerApplications();
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(color: greyColor, fontWeight: FontWeight.w700),
                  suffixIcon: InkWell(
                    onTap: () {
                      viewModel.searchTEC.clear();
                      viewModel.updateUI();
                    },
                    child: viewModel.searchTEC.text.isNotEmpty
                        ? SvgPicture.asset("assets/clearIcon.svg", height: 5, width: 5)
                        : Icon(viewModel.searchTEC.text.isNotEmpty?Icons.close:Icons.search, color: blackColorMono, size: 20,),
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
                  viewModel.updateUI();
                },
              ),
              const SizedBox(width: 20),
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
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: darkGreyColor,
                fontWeight: FontWeight.w400,
                fontSize: s + 1,
              ),
              showBottomBorder: true,
              columns: const [
                DataColumn(
                    label: Text("Product")),
                DataColumn(
                    label: Text("Type")),
                DataColumn(
                    label: Text("Application No.")),
                DataColumn(label: Text("Status")),
              ],
              rows: viewModel.productsModel.map(
                    (e) => DataRow(
                  cells: [
                    DataCell(Text(
                      e.name,
                      style: const TextStyle(
                          color: blackColorMono,
                          fontWeight:
                          FontWeight.w700,
                          fontSize: m),
                    )),
                    DataCell(Text(
                      e.type,
                      style: const TextStyle(
                          color: darkGreyColor,
                          fontWeight:
                          FontWeight.w500,
                          fontSize: m),
                    )),
                    DataCell(Text(
                      e.applicationNumber,
                      style: const TextStyle(
                          color: darkGreyColor,
                          fontWeight:
                          FontWeight.w500,
                          fontSize: m),
                    )),
                    DataCell(
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
                    ),
                  ],
                ),
              )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
