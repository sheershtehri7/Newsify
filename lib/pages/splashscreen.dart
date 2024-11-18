import 'dart:async';

import 'package:api_project_1/pages/CategoryPage.dart';

import 'package:api_project_1/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Categorypage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/6.jpg',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
              ),
              SpinKitChasingDots(
                color: const Color.fromARGB(255, 231, 117, 117),
                size: 70,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
