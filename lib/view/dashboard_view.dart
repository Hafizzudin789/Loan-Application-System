import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderGreyColor, width: 1)
              ),
              child: const Center(
                child: Text("Monthly summary"),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderGreyColor, width: 1),
                    ),

                    child: const Center(
                      child: Text("Notifications summary"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderGreyColor, width: 1),
                    ),
                    child: const Center(
                      child: Text("Enjoy 50% Cashback Deal for Petrol Credit Card"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderGreyColor, width: 1),
                    ),
                    child: const Center(
                      child: Text("Auto Finance Rate 2% with 1 year free service"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
