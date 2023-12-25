import 'package:flutter/material.dart';
import 'package:mobile/screen/layout.dart';

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
          const Text(
            'We’ve sent a code on your mobile for verification.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 69, 104),
              fontSize: 16,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please check your phone for the verification code. Enter the code to complete the verification process and unlock the full potential of our services.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Color.fromRGBO(89, 118, 134, 1),
              fontSize: 14,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Didn’t receive the code? ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color.fromRGBO(89, 118, 134, 1),
                  fontSize: 14,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Resend',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color.fromRGBO(0, 69, 104, 1),
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
              _buildVerificationCodeBox(),
              _buildVerificationCodeBox(),
              _buildVerificationCodeBox(),
              _buildVerificationCodeBox(),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Layout();
              }));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: const Color.fromARGB(255, 0, 69, 104),
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

  Widget _buildVerificationCodeBox() {
    return const SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color.fromRGBO(0, 69, 104, 1),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color.fromRGBO(0, 69, 104, 1),
              width: 3,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
