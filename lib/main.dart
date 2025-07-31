import 'package:flutter/material.dart';
import 'package:tourism_app/screen/another_screen.dart';
import 'package:tourism_app/screen/first_screen.dart';
import 'package:tourism_app/screen/replacement_screen.dart';
import 'package:tourism_app/screen/return_data_screen.dart';
import 'package:tourism_app/screen/second_screen.dart';
import 'package:tourism_app/screen/second_screen_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
        '/second-with-data': (context) => const SecondScreenWithData(),
        '/return-data': (context) => const ReturnDataScreen(),
        '/replacement': (context) => const ReplacementScreen(),
        '/another': (context) => const AnotherScreen(),
      },
    );
  }
}
