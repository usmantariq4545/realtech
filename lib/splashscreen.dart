import 'package:flutter/material.dart';
import 'package:realtech/log/redirect.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RedirectIon()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff307a59),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'asset/image/Logo.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Text(
              'REALTECH',
              style: TextStyle(fontSize: 30, color: Color(0xffe0bd87)),
            ),
            Text(
              'IN ROUTE TO TRANSFORMATION',
              style: TextStyle(fontSize: 14, color: Color(0xffe0bd87)),
            ),
          ],
        ),
      ),
    );
  }
}
