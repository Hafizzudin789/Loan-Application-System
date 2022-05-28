import 'package:flutter/material.dart';
import 'package:loan_application_system/view/widgets/footer.dart';

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
      child: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Center(
                child: child,
              ),
            ),
          ),
          const Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Footer(),
          ),
        ],
      ),
    );
  }
}
