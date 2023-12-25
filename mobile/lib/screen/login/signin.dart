import 'package:flutter/material.dart';
import 'package:mobile/screen/layout.dart';
import 'package:mobile/screen/login/or.dart';

class Login extends StatelessWidget {
  const Login({Key? key, required this.onChange}) : super(key: key);
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
                child: const Text('Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 208, 215, 219),
                    )),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Color.fromRGBO(31, 31, 31, 1),
                      fontSize: 14,
                      fontFamily: 'openSans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onChange(0);
                    },
                    child: const Text(
                      'Sing Up',
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
              const SizedBox(height: 20),
              const OR(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 50,
                    width: 50,
                    color: const Color.fromRGBO(230, 230, 230, 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 50,
                    width: 50,
                    color: const Color.fromRGBO(230, 230, 230, 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 50,
                    width: 50,
                    color: const Color.fromRGBO(230, 230, 230, 1),
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
