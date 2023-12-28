import 'package:flutter/material.dart';

class OnboardingContestSection extends StatelessWidget {
  const OnboardingContestSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        const Text(
          'Step into\nthe Excitement of Live Contests',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 208, 215, 219),
            fontSize: 32,
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
      ],
    );
  }
}
