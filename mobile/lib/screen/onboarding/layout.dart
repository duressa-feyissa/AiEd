import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screen/login/layout.dart';
import 'package:mobile/screen/onboarding/bubble.dart';
import 'package:mobile/screen/onboarding/contest.dart';
import 'package:mobile/screen/onboarding/innovate.dart';
import 'package:mobile/screen/onboarding/join.dart';
import 'package:mobile/screen/onboarding/learning.dart';
import 'package:mobile/screen/onboarding/slider.dart';
import 'package:mobile/screen/onboarding/starter.dart';

class OnboardingLayout extends StatefulWidget {
  const OnboardingLayout({Key? key}) : super(key: key);

  @override
  State<OnboardingLayout> createState() => _OnboardingLayoutState();
}

class _OnboardingLayoutState extends State<OnboardingLayout> {
  int index = 0;

  void onChange(int index) {
    if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EntranceLayout()),
      );
    } else if (index < 5) {
      setState(() {
        this.index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            setState(() {
              if (index > 0) {
                onChange(index - 1);
              }
            });
          } else {
            setState(() {
              if (index < 4) {
                onChange(index + 1);
              }
            });
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                  'assets/images/onBoarding/${index + 1}_${index + 1}.png',
                  fit: BoxFit.cover),
              const BubbleScreen(
                  numberOfBubbles: 3,
                  maxBubbleSize: 90,
                  color: Color.fromRGBO(255, 208, 215, 0.05)),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    index == 0
                        ? const OnboardingStarterSection()
                        : index == 1
                            ? const OnboardingLearningSection()
                            : index == 2
                                ? const OnboardingInnovateSection()
                                : index == 3
                                    ? const OnboardingContestSection()
                                    : const OnboardingJoinSection(),
                    OnboardingSlider(onChange: onChange, index: index),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ElevatedButton(
                      onPressed: () {
                        onChange(index + 1);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color.fromRGBO(89, 134, 157, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        index == 4 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 208, 215, 219),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
