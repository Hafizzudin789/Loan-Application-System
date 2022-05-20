import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("© 2021 Digibanc"),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: const [
              Text("Terms"),
              Text("Privacy"),
              Text("Supports"),
            ],
          )

        ],
      ),
    );
  }
}
