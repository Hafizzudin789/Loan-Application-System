import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_application_system/service_locator.dart';
import 'package:loan_application_system/services/navigation_service.dart';
import 'package:loan_application_system/services/routing_service.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/apply_applications_widget.dart';
import 'package:loan_application_system/view/widgets/custom_app_bar.dart';
import 'package:loan_application_system/view/widgets/elevated_button_widget.dart';
import 'package:loan_application_system/view/widgets/footer.dart';
import 'package:loan_application_system/view_model/customer_list_view_model.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomerListView extends ViewModelWidget<LayoutViewModel> {
  const CustomerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel layoutViewModel) {
    return ViewModelBuilder<CustomerListViewModel>.reactive(
      viewModelBuilder: () => CustomerListViewModel(),
      onDispose: (viewModel)=>viewModel.disposeResource(),
      builder: (context, viewModel, _) {
        return Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 0),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _navButtonsWidget(layoutViewModel, viewModel, context),
                    Expanded(
                      child: viewModel.customers.isEmpty
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                                SvgPicture.asset("assets/search.svg"),
                                const SizedBox(height: 10),
                                const Text(
                                  "Sorry, no result found",
                                  style: TextStyle(
                                      color: noResultColor,
                                      fontSize: l,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Your search was unfortunately not found or does’t exist.",
                                  style: TextStyle(color: darkGreyColor),
                                ),
                              ],
                            )
                          : SingleChildScrollView(
                              child: DataTable(
                                headingTextStyle: const TextStyle(
                                  color: darkGreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: s + 1,
                                ),
                                showBottomBorder: true,
                                columns: const [
                                  DataColumn(
                                      label: Text("Customer Name")),
                                  DataColumn(
                                      label: Text("CIF No.")),
                                  DataColumn(
                                      label: Text("ID Number")),
                                  DataColumn(label: Text("Mobile Number")),
                                  DataColumn(label: Text("Email address")),
                                ],
                                rows: viewModel.customers.map(
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
                                            e.cifNo.toString(),
                                            style: const TextStyle(
                                                color: darkGreyColor,
                                                fontWeight:
                                                    FontWeight.w500,
                                                fontSize: m),
                                          )),
                                          DataCell(Text(
                                            e.id,
                                            style: const TextStyle(
                                                color: darkGreyColor,
                                                fontWeight:
                                                    FontWeight.w500,
                                                fontSize: m),
                                          )),
                                          DataCell(Text(
                                            e.phoneNumber,
                                            style: const TextStyle(
                                                color: darkGreyColor,
                                                fontWeight:
                                                    FontWeight.w500,
                                                fontSize: m),
                                          )),
                                          DataCell(Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  e.email,
                                                  style: const TextStyle(
                                                      color: darkGreyColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: m),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  locator<NavigationService>().navigateToAndBack(customerProfileView);
                                                },
                                                child: const Icon(Icons.more_vert),
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                    ),
                    const SizedBox(height: 5),
                    _tableFooter(viewModel),
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

  Widget _navButtonsWidget(LayoutViewModel layoutViewModel, CustomerListViewModel viewModel, BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          offset: const Offset(0, 40),
          itemBuilder: (context) => viewModel.sortList.map(
                (e) => PopupMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ),
          ).toList(),
          onSelected: (String value) {
            viewModel.selectSortBy(value);
          },
          child: ElevatedButtonWidget(text: viewModel.sortBy, iconData: Icons.keyboard_arrow_down_rounded),
        ),

        const Expanded(child: SizedBox()),
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
        const SizedBox(width: 15),
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
              showApplyApplicationsPopUp(context, layoutViewModel);
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

  Widget _tableFooter(CustomerListViewModel viewModel) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // if(applicationsViewModel.pageNumber != 1) {
            //   applicationsViewModel.changePage(applicationsViewModel.pageNumber-1);
            // }
          },
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              border: Border.all(color: borderGreyColor, width: 1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: viewModel.pageNumber != 1? blackColorMono:idleGreyColor,),
          ),
        ),
        const SizedBox(width: 8),
        _pageNumberWidget(viewModel, 1),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {},
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              border: Border.all(color: borderGreyColor, width: 1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: (viewModel.pageNumber != 3)
                ? blackColorMono
                : idleGreyColor,
            ),
          ),
        ),

        const Expanded(child: SizedBox()),
        const Text(
          "Showing 1 - 10 of 56",
          style: TextStyle(
            color: darkGreyColor,
            fontSize: s - 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<ResultLimit>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          itemBuilder: (context) => viewModel.resultLimitList.map(
                (e) => PopupMenuItem<ResultLimit>(
                  value: e,
                  child: Text(e.value.toString()),
                ),
          ).toList(),
          onSelected: (ResultLimit value) {
            viewModel.changeResultLimit(value);
          },
          child: ElevatedButtonWidget(text: viewModel.resultLimit.value.toString(), iconData: Icons.keyboard_arrow_down_rounded),
        ),
      ],
    );
  }

  Widget _pageNumberWidget(CustomerListViewModel viewModel, int page) {
    return InkWell(
      onTap: () {
        // viewModel.changePage(page);
      },
      child: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          border: Border.all(color: borderGreyColor, width: 1),
          shape: BoxShape.circle,
          color: viewModel.pageNumber== page?Colors.white:lightGreyColor,
        ),
        alignment: Alignment.center,
        child: Text(page.toString(), style: TextStyle(fontWeight: FontWeight.w700, color: viewModel.pageNumber== page? blackColorMono: darkGreyColor),),
      ),
    );
  }
}

