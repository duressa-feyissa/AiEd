import 'package:flutter/material.dart';
import 'package:mobile/screen/login/or.dart';

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
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          const Text(
            'LUCY HACK',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 69, 104),
              fontSize: 32,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'First Name',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'School',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.school_outlined),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Phone',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.phone_outlined),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.lock_outlined),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.remove_red_eye_outlined),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    label: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 31, 31, 1),
                          fontSize: 15,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.lock_outlined),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.remove_red_eye_outlined),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
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
                  backgroundColor: const Color.fromARGB(255, 0, 69, 104),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 208, 215, 219),
                    )),
              ),
              const SizedBox(height: 20),
              const OR(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color.fromRGBO(31, 31, 31, 1),
                      fontSize: 14,
                      fontFamily: 'openSans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onChange(1);
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 69, 104, 1),
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
