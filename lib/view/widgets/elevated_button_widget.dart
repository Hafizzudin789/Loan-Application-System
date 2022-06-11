import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  const ElevatedButtonWidget({Key? key, required this.text, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: borderGreyColor, width: 1),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: borderGreyColor, blurRadius: 0.5, spreadRadius: 1, offset: Offset(-0.5, 2))
        ],
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w700, color: blackColorMono),
          ),
          const SizedBox(width: 10),
          Icon(
            iconData,
            size: 20,
          )
        ],
      ),
    );
  }
}
