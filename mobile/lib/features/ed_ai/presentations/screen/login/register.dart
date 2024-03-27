import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/ed_ai/presentations/screen/login/or.dart';

class Register extends StatelessWidget {
  const Register({Key? key, required this.onChange}) : super(key: key);

  final void Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Text(
            'LUCY HACK',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AdaptiveTheme.of(context).mode.isDark
                  ? Colors.white.withOpacity(0.8)
                  : const Color.fromARGB(255, 0, 69, 104),
              fontSize: 32,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'First Name',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'School',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.school_outlined,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Phone',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.phone_outlined,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.lock_outlined,
                      ),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? Colors.white.withOpacity(0.5)
                              : const Color.fromRGBO(31, 31, 31, 0.6),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.lock_outlined,
                      ),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  onChange(2);
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
                child: Text('Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white.withOpacity(0.8)
                          : const Color.fromARGB(255, 208, 215, 219),
                    )),
              ),
              const SizedBox(height: 20),
              const OR(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white.withOpacity(0.8)
                          : const Color.fromRGBO(31, 31, 31, 0.6),
                      fontSize: 14,
                      fontFamily: 'openSans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onChange(1);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.5)
                            : const Color.fromARGB(255, 0, 69, 104),
                        fontSize: 14,
                        fontFamily: 'openSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
