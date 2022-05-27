import 'package:flutter/material.dart';

class ApplicationsView extends StatefulWidget {
  const ApplicationsView({Key? key}) : super(key: key);

  @override
  State<ApplicationsView> createState() => _ApplicationsViewState();
}

class _ApplicationsViewState extends State<ApplicationsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Applications View"),
    );
  }
}
