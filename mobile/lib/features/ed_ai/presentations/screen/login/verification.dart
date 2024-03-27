import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class Verfication extends StatelessWidget {
  const Verfication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            'We’ve sent a code on your mobile for verification.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: AdaptiveTheme.of(context).mode.isDark
                  ? Colors.white.withOpacity(0.8)
                  : const Color.fromARGB(255, 0, 69, 104),
              fontSize: 16,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Please check your phone for the verification code. Enter the code to complete the verification process and unlock the full potential of our services.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: AdaptiveTheme.of(context).mode.isDark
                  ? Colors.white.withOpacity(0.5)
                  : const Color.fromARGB(255, 0, 69, 104),
              fontSize: 14,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Didn’t receive the code? ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AdaptiveTheme.of(context).mode.isDark
                      ? Colors.white.withOpacity(0.5)
                      : const Color.fromARGB(255, 0, 69, 104),
                  fontSize: 14,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Resend',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AdaptiveTheme.of(context).mode.isDark
                      ? Colors.white.withOpacity(0.8)
                      : const Color.fromARGB(255, 0, 69, 104),
                  fontSize: 14,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildVerificationCodeBox(context),
              _buildVerificationCodeBox(context),
              _buildVerificationCodeBox(context),
              _buildVerificationCodeBox(context),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? Colors.white.withOpacity(0.05)
                  : const Color.fromARGB(255, 0, 69, 104),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('Verify',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 208, 215, 219),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCodeBox(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AdaptiveTheme.of(context).mode.isDark
                  ? Colors.white.withOpacity(0.8)
                  : const Color.fromARGB(255, 0, 69, 104),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AdaptiveTheme.of(context).mode.isDark
                  ? Colors.white.withOpacity(0.5)
                  : const Color.fromARGB(255, 0, 69, 104),
              width: 3,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
