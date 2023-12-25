import 'package:flutter/material.dart';
import 'package:mobile/screen/onboarding/layout.dart';

void main() {
  runApp(
    MaterialApp(
      home: const OnboardingLayout(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
