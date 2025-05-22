import 'package:flutter/material.dart';
import 'package:qr_code_scanner_generator/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QR Code SCanner and Generator",
      home: HomePage(),
    );
  }
}
