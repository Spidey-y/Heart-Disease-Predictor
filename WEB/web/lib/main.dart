import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/new_user.dart';
import 'package:websafe_svg/websafe_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      title: 'Heart Disease Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: prefer_const_constructors
                  title(),
                  const SizedBox(height: 20),
                  const Text(
                    "Discover your heart's future with our service, a smart website utilizing Machine Learning to predict personalized heart disease risks and provide actionable insights for a healthier tomorrow",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, color: Colors.black38),
                  ),
                  const SizedBox(height: 50),
                  addNewButton(context),
                  const SizedBox(height: 20),
                  historyButton(),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: WebsafeSvg.asset('assets/heart.svg')),
          ],
        ),
      ),
    );
  }

  Column title() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            'Heart Disease',
            maxLines: 2,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              color: Colors.blue,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            'Prediction',
            maxLines: 2,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  InkWell addNewButton(context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AddNewUser()));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Text("New Patient",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            )),
      ),
    );
  }

  InkWell historyButton() {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.white,
          border: Border.all(
            color: Colors.blue.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Text("History",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            )),
      ),
    );
  }
}

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
