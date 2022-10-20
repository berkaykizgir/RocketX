import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      title: 'RocketX',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RocketX'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
