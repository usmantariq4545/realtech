import 'package:flutter/material.dart';

import '../reuseable widget/text_constraint.dart';

class GEmailVerification extends StatelessWidget {
  const GEmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope is used to handle keyboard-related interactions
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
              child: Center(
                child: Column(
                  children: [
                    PText(
                      'Verification Email',
                      fontSize: 22,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    PText('Please enter the code we just sent to email'),
                    PText(
                      'usmantariq122@gmail.com',
                      fontSize: 16,
                      color: Color(0xff2e7b5b),
                      weight: FontWeight.w400,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            //   color: Color(0xffeaeaea),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFEAEAEA),
                                hintStyle:
                                    TextStyle(fontSize: 20.0, letterSpacing: 2),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 60,
                            //   color: Color(0xffeaeaea),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFEAEAEA),
                                hintStyle:
                                    TextStyle(fontSize: 20.0, letterSpacing: 2),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 60,
                            //   color: Color(0xffeaeaea),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFEAEAEA),
                                hintStyle:
                                    TextStyle(fontSize: 20.0, letterSpacing: 2),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 60,
                            //   color: Color(0xffeaeaea),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFEAEAEA),
                                hintStyle:
                                    TextStyle(fontSize: 20.0, letterSpacing: 2),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: PText('If you didn\'t receive a code?',
                              color: Colors.black, fontSize: 16),
                        ),
                        MaterialButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const SignUp()),
                            // );
                          },
                          child: PText('Resend',
                              color: Color(0xff2e7b5b), fontSize: 18),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Login()),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: PText('Continue',
                                fontSize: 26, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
