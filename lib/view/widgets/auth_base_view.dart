import 'package:flutter/material.dart';

class AuthBaseView extends StatelessWidget {
  final Widget child;
  const AuthBaseView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
