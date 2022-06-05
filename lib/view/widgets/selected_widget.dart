import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';

class SelectedWidget extends StatelessWidget {
  final bool isSelected;
  const SelectedWidget({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: idleGreyColor, width: 1),
        color: isSelected
            ? primaryColor
            : Colors.transparent,
      ),
      alignment: Alignment.center,
      child: isSelected
          ? const Icon(
        Icons.done,
        size: 15,
        color: Colors.white,
      )
          : const SizedBox(),
    );
  }
}
