import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_application_system/data.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {


  List<ApplicationData> applicationData = [
    ApplicationData(23, "Completed"),
    ApplicationData(15, "In Progress"),
    ApplicationData(2, "Rejected"),
  ];

  // List<TypesCountData> typesCountData = <TypesCountData>[
  //   TypesCountData(value: 45, label: "Credit\nCard"),
  //   TypesCountData(value: 23, label: "Personal\nLoan"),
  //   TypesCountData(value: 15, label: "Auto\nLoan"),
  // ];
  List<TypesCountData> typesCountCrData = <TypesCountData>[
    TypesCountData(value: 45, label: "Credit\nCard"),
  ];
  List<TypesCountData> typesCountPData = <TypesCountData>[
    TypesCountData(value: 23, label: "Personal\nLoan"),
  ];
  List<TypesCountData> typesCountLoanData = <TypesCountData>[
    TypesCountData(value: 15, label: "Auto\nLoan"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: _monthlySummaryWidget(),
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
    );
  }

  Widget _monthlySummaryWidget() {
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
                          Text("Monthly summary", style: Theme.of(context).textTheme.headline2,),
                          Text("Last updated 16 May 2022", style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: borderGreyColor))),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(blackColor),
                      ),
                      child: Row(
                        children: const [
                          Text("Monthly", style: TextStyle(fontWeight: FontWeight.w700),),
                          SizedBox(width: 10),
                          Icon(Icons.keyboard_arrow_down_rounded, size: 20,)
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("36,400.00 BHD", style: TextStyle(color: greenColor, fontWeight: FontWeight.w700, fontSize: xxl),),
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
                              text: "40",
                              style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(text: "  \nApplications", style: Theme.of(context).textTheme.bodyText1)
                              ]
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    series: <DoughnutSeries>[
                      DoughnutSeries<ApplicationData, String>(
                        dataSource: applicationData,
                        xValueMapper: (ApplicationData data, _)=>data.label,
                        yValueMapper: (ApplicationData data, _)=>data.value,
                        // dataLabelSettings: const DataLabelSettings(isVisible: true),
                        startAngle: -90,
                        endAngle: 270,
                        innerRadius: "82%",
                        radius: "85%",
                        animationDuration: 1000,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "23",
                                  style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(text: "  Completed", style: Theme.of(context).textTheme.bodyText1)
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              color: lightYellowColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "15",
                                  style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(text: "  In Progress", style: Theme.of(context).textTheme.bodyText1)
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              color: warningColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "2",
                                  style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(text: "  Rejected", style: Theme.of(context).textTheme.bodyText1)
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _barWidget(errorColor, "Credit\nCard", 45),
                  _barWidget(yellowColor, "Personal\nLoan", 23),
                  _barWidget(greenColor, "Auto\nLoan", 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationWidget() {
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
                  style: Theme.of(context).textTheme.headline2,
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
                      style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(text: "  Application is not complete", style: Theme.of(context).textTheme.bodyText1)
                      ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "11",
                        style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(text: "  Customer has expiry ID", style: Theme.of(context).textTheme.bodyText1)
                        ]
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "21",
                        style: const TextStyle(fontSize: m+1, color: blackColor, fontWeight: FontWeight.w500),
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

  Widget _discountWidget() {
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
          Text("Enjoy 50% Cashback Deal for Petrol Credit Card", style: Theme.of(context).textTheme.headline2,),

          Text("Lorem Ipsum Sit Dolor Amet ", style: Theme.of(context).textTheme.bodyText1,),
        ],
      ),
    );
  }

  Widget _financeWidget() {
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
          Text("Auto Finance Rate 2% with 1 year free service", style: Theme.of(context).textTheme.headline2,),

          Text("Lorem Ipsum Sit Dolor Amet ", style: Theme.of(context).textTheme.bodyText1,),
        ],
      ),
    );
  }

  Widget _barWidget(Color color, String label, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w700,
            fontSize: m + 1,
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          child: Container(
            width: 20,
            height: value.toDouble()*3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,),
      ],
    );
  }
}

