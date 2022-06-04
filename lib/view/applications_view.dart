import 'package:flutter/material.dart';
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
      children: const [
        CustomAppBar(),
        Expanded(child: Center(child: Text("Applications View"))),
        Footer(),
      ],
    );
  }
}
