import 'package:flutter/material.dart';
import 'package:mobiquiz/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MobiQuiz",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: splash(),
    );
  }
}
