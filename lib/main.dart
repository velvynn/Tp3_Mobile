import 'package:flutter/material.dart';
import 'package:pertemuan3/BMIScreen.dart'; // Pastikan nama package sesuai dengan pubspec.yaml Anda

void main() {
  runApp(const BMIAPP());
}

class BMIAPP extends StatelessWidget {
  const BMIAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KALKULATOR BMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const BMIScreen(),
    );
  }
}