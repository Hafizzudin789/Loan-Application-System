import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Function onDispose;
  final Widget child;
  const StatefulWrapper({Key? key, required this.onInit, required this.child, required this.onDispose}): super(key: key);

  @override
  State<StatefulWrapper> createState() => _StatefulWrapperState();
}
class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    widget.onDispose();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}