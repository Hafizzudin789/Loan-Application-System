import 'package:flutter/material.dart';
import 'package:loan_application_system/utils/color_constant.dart';
import 'package:loan_application_system/utils/font_size.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _textWidget("© 2021 Digibanc"),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              _textWidget("Terms"),
              _textWidget("Privacy"),
              _textWidget("Supports"),
            ],
          )
        ],
      ),
    );
  }

  Widget _textWidget(String value) {
    return Text(value, style: const TextStyle(color: darkGreyColor, fontSize: s),);
  }
}
