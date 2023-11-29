import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResultPage extends StatelessWidget {
  ResultPage({super.key, required this.isHeartDisease});
  int isHeartDisease;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isHeartDisease == 0
                  ? "assets/healthy.gif"
                  : "assets/unhealthy.gif",
            ),
            const SizedBox(height: 20),
            Text(
              isHeartDisease == 0
                  ? "The model predicts that the patient is risk free from heart disease"
                  : "The model predicts that the patient is at risk of heart disease",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
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
                      color: Colors.blue.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Text("Home page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
