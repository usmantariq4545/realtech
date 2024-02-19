import 'package:flutter/material.dart';
import 'package:realtech/log/login.dart';
import 'package:realtech/log/registeration.dart';
import '../reuseable widget/text_constraint.dart';

class RedirectIon extends StatelessWidget {
  const RedirectIon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/image/logo2.png',
                    width: 60,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'REALTECH',
                        style: TextStyle(
                            fontSize: 33,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'IN ROUTE TO TRANSFORMATION',
                        style: TextStyle(fontSize: 11, letterSpacing: 0.1),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Image.asset('asset/image/build.png'),
              SizedBox(
                height: 10,
              ),
              PText('Unlock Your Future',
                  fontSize: 26, weight: FontWeight.w500),
              Text(
                textAlign: TextAlign.center,
                'Navigate the Real State Market\n with Confidence',
                style: TextStyle(
                  fontSize: 16,
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
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child:
                        PText('Get Started', fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xffdcefe9), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child:
                        PText('Log In', fontSize: 22, color: Color(0xff2e7b5b)),
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
