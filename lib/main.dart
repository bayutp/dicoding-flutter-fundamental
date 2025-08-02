import 'package:flutter/material.dart';

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
      home: Scaffold(
        body: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 100,
            maxWidth: 200,
            maxHeight: 200,
          ),
          child: Container(width: 1000, height: 1000, color: Colors.amber),
        ),
      ),
    );
  }
}
