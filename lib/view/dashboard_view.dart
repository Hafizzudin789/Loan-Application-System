import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:loan_application_system/view/widgets/custom_app_bar.dart';
import 'package:loan_application_system/view/widgets/elevated_button_widget.dart';
import 'package:loan_application_system/view/widgets/footer.dart';
import 'package:loan_application_system/view_model/layout_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends ViewModelWidget<LayoutViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LayoutViewModel viewModel) {
    return Column(
      children: [
        const CustomAppBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: _monthlySummaryWidget(viewModel),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _notificationWidget(),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: _discountWidget(),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: _financeWidget(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Footer(),
      ],
    );
  }

  Widget _monthlySummaryWidget(LayoutViewModel viewModel) {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderGreyColor, width: 1),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Monthly summary", style: Theme.of(context).textTheme.headline3,),
                              Text("Last updated 16 May 2022", style: Theme.of(context).textTheme.bodyText1,),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          itemBuilder: (context) => viewModel.dropdownYear.map(
                              (e) => PopupMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ),
                          ).toList(),
                          onSelected: (String value) {
                            viewModel.selectDropDownYear(value);
                          },
                          child: ElevatedButtonWidget(text: viewModel.selectedYear, iconData: Icons.keyboard_arrow_down_rounded),
                        ),

                        const SizedBox(width: 10),

                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          itemBuilder: (context) => viewModel.dropdownMonth.map(
                                (e) => PopupMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ),
                          ).toList(),
                          constraints: const BoxConstraints(
                            maxHeight: 500,
                          ),
                          onSelected: (String value) {
                            viewModel.selectDropDownMonth(value);
                          },
                          child: ElevatedButtonWidget(text: viewModel.selectedMonth, iconData: Icons.keyboard_arrow_down_rounded),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ButtonStyle(
                        //     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                        //     backgroundColor: MaterialStateProperty.all(Colors.white),
                        //     foregroundColor: MaterialStateProperty.all(blackColorMono),
                        //   ),
                        //   child: Row(
                        //     children: const [
                        //       Text("Monthly", style: TextStyle(fontWeight: FontWeight.w700),),
                        //       SizedBox(width: 10),
                        //       Icon(Icons.keyboard_arrow_down_rounded, size: 20,)
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${viewModel.totalVolume} BHD", style: const TextStyle(color: greenColor, fontWeight: FontWeight.w700, fontSize: xxl),),
                        Row(
                          children: [
                            Text("Total Volume", style: Theme.of(context).textTheme.bodyText1,),
                            const SizedBox(width: 3),
                            const Icon(Icons.info_outline_rounded, size: 14, color: darkGreyColor,)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: SfCircularChart(
                        margin: EdgeInsets.zero,
                        palette: const [greenColor, lightYellowColor, warningColor],
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                            widget: RichText(
                              text: TextSpan(
                                  text: viewModel.getTotalSelectedApplicationsCount().toString(),
                                  style: const TextStyle(fontSize: m+1, color: blackColorMono, fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(text: "  \nApplications", style: Theme.of(context).textTheme.bodyText1)
                                  ]
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        series: <DoughnutSeries>[
                          DoughnutSeries<ApplicationStatusModel, String>(
                            dataSource: viewModel.applicationsCountData,
                            xValueMapper: (ApplicationStatusModel data, _)=>data.label,
                            yValueMapper: (ApplicationStatusModel data, _)=>data.value,
                            // dataLabelSettings: const DataLabelSettings(isVisible: true),
                            startAngle: -90,
                            endAngle: 270,
                            innerRadius: "82%",
                            radius: "85%",
                            animationDuration: 800,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: viewModel.applicationsCountData
                            .map(
                              (e) => _labelWidget(
                                e.label,
                                e.value,
                              ),
                            ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 4,
                // child: SfCartesianChart(
                //   palette: const [errorColor, yellowColor, greenColor],
                //   plotAreaBorderWidth: 0,
                //   primaryXAxis: CategoryAxis(
                //     majorGridLines: const MajorGridLines(width: 0),
                //     axisLine: const AxisLine(width: 0),
                //     majorTickLines: const MajorTickLines(
                //       // width: 0,
                //       // size: 0,
                //       color: Colors.transparent
                //     ),
                //     labelsExtent: 100,
                //     labelAlignment: LabelAlignment.center,
                //     // maximumLabelWidth: 100
                //   ),
                //   primaryYAxis: NumericAxis(
                //     isVisible: false,
                //   ),
                //   enableSideBySideSeriesPlacement: true,
                //   series: <ColumnSeries<TypesCountData,String>>[
                //     ColumnSeries<TypesCountData, String>(
                //       dataSource: typesCountCrData,
                //       xValueMapper: (TypesCountData data, _) => data.label,
                //       yValueMapper: (TypesCountData data, _) => data.value,
                //       dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: m+1)),
                //       width: 0.4,
                //       borderRadius: BorderRadius.circular(100),
                //     ),
                //     ColumnSeries<TypesCountData, String>(
                //       dataSource: typesCountPData,
                //       xValueMapper: (TypesCountData data, _) => data.label,
                //       yValueMapper: (TypesCountData data, _) => data.value,
                //       dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: m+1)),
                //       width: 0.4,
                //       borderRadius: BorderRadius.circular(100),
                //     ),
                //     ColumnSeries<TypesCountData, String>(
                //       dataSource: typesCountLoanData,
                //       xValueMapper: (TypesCountData data, _) => data.label,
                //       yValueMapper: (TypesCountData data, _) => data.value,
                //       dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: m+1)),
                //       width: 0.4,
                //       borderRadius: BorderRadius.circular(100),
                //     ),
                //   ],
                //
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: viewModel.applicationData
                        .map((e) => _barWidget(e.color, e.label, e.value),)
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _labelWidget(String label, int value) {
    return Builder(
      builder: (context) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: label == "Completed"
                    ? greenColor
                    : label == "In Progress"
                      ? lightYellowColor
                      : warningColor,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: value.toString(),
                    style: const TextStyle(fontSize: m+1, color: blackColorMono, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(text: "  $label", style: Theme.of(context).textTheme.bodyText1)
                    ]
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _notificationWidget() {
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: lightGreyColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderGreyColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16),),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset("assets/notificationIcon.svg"),
                    const SizedBox(width: 8),
                    Text(
                      "Notifications summary",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "13",
                            style: const TextStyle(fontSize: m+1, color: blackColorMono, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(text: "  Application is not complete", style: Theme.of(context).textTheme.bodyText1)
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: "11",
                            style: const TextStyle(fontSize: m+1, color: blackColorMono, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(text: "  Customer has expiry ID", style: Theme.of(context).textTheme.bodyText1)
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: "21",
                            style: const TextStyle(fontSize: m+1, color: blackColorMono, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(text: "  Customer expiry ID is next month", style: Theme.of(context).textTheme.bodyText1)
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _discountWidget() {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0XFFF2EBFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderGreyColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: borderGreyColor)
                ),
                child: SvgPicture.asset("assets/discountIcon.svg"),
              ),
              Text("Enjoy 50% Cashback Deal for Petrol Credit Card", style: Theme.of(context).textTheme.headline3,),

              Text("Lorem Ipsum Sit Dolor Amet ", style: Theme.of(context).textTheme.bodyText1,),
            ],
          ),
        );
      }
    );
  }

  Widget _financeWidget() {
    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0XFFFFFBED),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderGreyColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: borderGreyColor)
                ),
                child: SvgPicture.asset("assets/carIcon.svg"),
              ),
              Text("Auto Finance Rate 2% with 1 year free service", style: Theme.of(context).textTheme.headline3,),

              Text("Lorem Ipsum Sit Dolor Amet ", style: Theme.of(context).textTheme.bodyText1,),
            ],
          ),
        );
      }
    );
  }

  Widget _barWidget(Color color, String label, int value) {
    return Expanded(
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value.toString(),
                style: const TextStyle(
                  color: blackColorMono,
                  fontWeight: FontWeight.w700,
                  fontSize: m + 1,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Container(
                  width: 20,
                  height: value.toDouble()*3,
                  // height: color == errorColor
                  //     ? 45*3
                  //     : color == yellowColor
                  //       ? 23*3
                  //       : 15*3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}


