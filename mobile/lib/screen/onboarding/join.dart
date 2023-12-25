import 'package:flutter/material.dart';

class OnboardingJoinSection extends StatelessWidget {
  const OnboardingJoinSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'JOIN NOW',
          style: TextStyle(
            color: Color.fromARGB(255, 208, 215, 219),
            fontSize: 14,
            fontFamily: 'openSans',
            fontWeight: FontWeight.w400,
            letterSpacing: 8,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        const Text(
          'Join Our Community to Learn and Discuss',
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
