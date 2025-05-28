// Note, the example doesn't make much sense without looking at example/pubspec.yaml.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'download_transformer example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/texture_atlas.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
