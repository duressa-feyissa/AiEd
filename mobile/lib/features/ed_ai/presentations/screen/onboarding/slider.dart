import 'package:flutter/material.dart';

class OnboardingSlider extends StatefulWidget {
  const OnboardingSlider(
      {super.key, required this.onChange, required this.index});

  final void Function(int) onChange;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return _OnboardingSliderState();
  }
}

class _OnboardingSliderState extends State<OnboardingSlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 5; i++)
          Container(
            width: widget.index == i ? 30 : 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 208, 215, 219),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
      ],
    );
  }
}
