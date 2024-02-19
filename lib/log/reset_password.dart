import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:realtech/log/login.dart';

import '../reuseable widget/text_constraint.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xff2e7b5b),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          height: MediaQuery.of(context).size.height * 0.75,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 50,
                    color: Colors.white,
                  )),
            ),
            PText(
              "Reset Password.",
              color: Colors.white,
              fontSize: 20,
            ),
            SizedBox(
              height: 50,
            ),
            PText(
              'Email',
              fontSize: 26.0,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: TextField(
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
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffdcefe9), // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Set the border radius
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Login(),
                          )))
                      .onError((error, stackTrace) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Your email is incorrect',
                      backgroundColor: Colors.black,
                      titleColor: Colors.white,
                      textColor: Colors.white,
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: PText('Send', fontSize: 22, color: Color(0xff2e7b5b)),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: MaterialButton(
            //     onPressed: () {
            //       FirebaseAuth.instance
            //           .sendPasswordResetEmail(email: _emailTextController.text)
            //           .then((value) =>
            //               Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (context) => MainScreen(),
            //               )))
            //           .onError((error, stackTrace) {
            //         QuickAlert.show(
            //           context: context,
            //           type: QuickAlertType.error,
            //           title: 'Oops...',
            //           text: 'Your email is incorrect',
            //           backgroundColor: Colors.black,
            //           titleColor: Colors.white,
            //           textColor: Colors.white,
            //         );
            //       });
            //     },
            //     color: Color.fromARGB(255, 74, 30, 155),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         side: BorderSide(color: Colors.white)),
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Icon(
            //         Icons.arrow_right_alt_rounded,
            //         size: 40,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            Spacer(),
            PText(
              'By registering, you agree to our Terms and Conditions and Privacy Policy.',
              fontSize: 15,
            ),
          ],
        ),
      ]),
    );
  }
}
