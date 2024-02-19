import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:realtech/log/registeration.dart';
import 'package:realtech/log/reset_password.dart';
import 'package:realtech/screens/mainscreen.dart';
import '../reuseable widget/text_constraint.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

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
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PText(
                          'Welcome Back',
                          fontSize: 26.0,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Transform.rotate(
                          angle: 90 *
                              (3.1415926535 /
                                  -180), // Rotate by 45 degrees (in radians)
                          child: Icon(
                            Icons.waving_hand_rounded,
                            color: Color(0xffffc621),
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                    PText('Sign in your account',
                        fontSize: 16.0, color: Colors.grey),
                    Spacer(),
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
                        hintStyle: TextStyle(fontSize: 14.0, letterSpacing: 2),
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
                      'Password',
                      fontSize: 18.0,
                    ),
                    TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEAEAEA),
                        hintText: 'Your Password',
                        hintStyle: TextStyle(fontSize: 14.0, letterSpacing: 2),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResetPassword(),
                          ));
                        },
                        child: PText(
                          'Forget Password?',
                          color: Color(0xff2e7b5b),
                          fontSize: 17,
                          weight: FontWeight.w400,
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
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
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
                              text: 'Log In Successful',
                              autoCloseDuration: const Duration(seconds: 2),
                            );
                          }).onError((error, stackTrace) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Your email or password is incorrect',
                              backgroundColor: Colors.black,
                              titleColor: Colors.white,
                              textColor: Colors.white,
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: PText('Log In',
                              fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: PText('Don\'t have an account?',
                              color: Colors.black, fontSize: 14),
                        ),
                        Flexible(
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: PText('Sign Up',
                                color: Color(0xff2e7b5b), fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Align(
                        alignment: Alignment.center,
                        child: PText('Or With', fontSize: 20)),
                    Spacer(),
                    _user != null ? _userInfo() : _googleSignInButton(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           Colors.white, // Button background color
                    //       shape: RoundedRectangleBorder(
                    //         side: BorderSide(color: Colors.black, width: 2),
                    //         borderRadius: BorderRadius.circular(
                    //             10.0), // Set the border radius
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => Login()),
                    //       );
                    //     },
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'asset/image/apple.png',
                    //             width: 30,
                    //             height: 30,
                    //             fit: BoxFit.cover,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           PText('Sign in with Apple',
                    //               fontSize: 20, color: Colors.black),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _googleSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Button background color
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10.0), // Set the border radius
          ),
        ),
        onPressed: _handleGoogleSignIn,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/image/google.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 5,
              ),
              PText('Sign in with Google', fontSize: 20, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (_user!.photoURL != null) // Null check added here
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_user!.photoURL!),
                ),
              ),
            ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Text(_user!.email ?? "")), // Null check added here
          Text(_user!.displayName ?? ""),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: MaterialButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PText(
                    "Sign Out",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
}
