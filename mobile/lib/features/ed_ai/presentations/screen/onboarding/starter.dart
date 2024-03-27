import 'package:flutter/material.dart';

class OnboardingStarterSection extends StatelessWidget {
  const OnboardingStarterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'LUCY HACK',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 208, 215, 219),
            fontSize: 32,
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        const Text(
          'RENEW',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 208, 215, 219),
            fontSize: 14,
            fontFamily: 'openSans',
            fontWeight: FontWeight.w400,
            letterSpacing: 8,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.225),
      ],
    );
  }
}
