import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screen/login/register.dart';
import 'package:mobile/screen/login/signin.dart';
import 'package:mobile/screen/login/verification.dart';
import 'package:mobile/screen/onboarding/bubble.dart';

class EntranceLayout extends StatefulWidget {
  const EntranceLayout({Key? key}) : super(key: key);

  @override
  State<EntranceLayout> createState() => _EntranceLayoutState();
}

class _EntranceLayoutState extends State<EntranceLayout> {
  int index = 1;

  void onChange(int index) {
    if (index == 0 || index == 1 || index == 2) {
      setState(() {
        this.index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Stack(
        children: [
          const BubbleScreen(
            maxBubbleSize: 90,
            numberOfBubbles: 4,
            color: Color.fromRGBO(0, 0, 0, 0.02),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
            child: index == 2
                ? const Verfication()
                : index == 1
                    ? Login(onChange: onChange)
                    : Register(onChange: onChange),
          ),
        ],
      ),
    );
  }
}
