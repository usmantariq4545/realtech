import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../reuseable widget/text_constraint.dart';
import '../screens/mainscreen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _nameTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope is used to handle keyboard-related interactions
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 30,
                    color: Colors.black,
                  )),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PText(
                        'Sign Up',
                        fontSize: 26.0,
                        weight: FontWeight.w500,
                      ),
                      PText('Create account',
                          fontSize: 18.0, color: Colors.grey),
                      SizedBox(height: 10.0),
                      Spacer(),
                      PText(
                        'Name',
                        fontSize: 18.0,
                      ),
                      TextField(
                        controller: _nameTextController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEAEAEA),
                          hintText: 'Your Name',
                          hintStyle:
                              TextStyle(fontSize: 14.0, letterSpacing: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PText(
                        'Email',
                        fontSize: 18.0,
                      ),
                      TextField(
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEAEAEA),
                          hintText: 'Your Email',
                          hintStyle:
                              TextStyle(fontSize: 14.0, letterSpacing: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PText(
                        'Password',
                        fontSize: 18.0,
                      ),
                      TextField(
                        obscureText: true,
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEAEAEA),
                          hintText: 'Your Password',
                          hintStyle:
                              TextStyle(fontSize: 14.0, letterSpacing: 2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xff2e7b5b), // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            setState(() {});
                            String id = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
                            fireStore
                                .doc(id)
                                .set({
                                  'name': _nameTextController.text,
                                  'email': _emailTextController.text,
                                  'password': _passwordTextController.text,
                                  'id': id,
                                })
                                .then((value) {})
                                .onError((error, stackTrace) {
                                  print('there is an issue');
                                });

                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Registeration Successful ',
                                autoCloseDuration: const Duration(seconds: 1),
                              );
                            }).onError((error, stackTrace) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text:
                                    'Try To Write Correct Email Format or Strong Password',
                                backgroundColor: Colors.black,
                                titleColor: Colors.white,
                                textColor: Colors.white,
                              );
                            }).then((value) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Registration Successful ',
                                autoCloseDuration:
                                    const Duration(milliseconds: 1),
                              );
                            }).catchError((error) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Registration failed: $error',
                                backgroundColor: Colors.black,
                                titleColor: Colors.white,
                                textColor: Colors.white,
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: PText('Register',
                                fontSize: 26, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PText('Have an account?',
                              color: Colors.black, fontSize: 18),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: PText('Sign In',
                                color: Color(0xff2e7b5b), fontSize: 20),
                          ),
                        ],
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: PText('By clicking register, you agree to our',
                            fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: PText('Terms and Policy',
                            fontSize: 16,
                            color: Color(0xff2e7b5b),
                            weight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
