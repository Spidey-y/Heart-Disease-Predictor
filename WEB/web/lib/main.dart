import 'package:flutter/material.dart';
import 'package:web/new_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Disease Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(92, 130, 192, 1)),
        useMaterial3: true,
      ),
      home: const AddNewUser(),
    );
  }
}
