
import 'package:flutter/material.dart';
import 'screens/ecopoint_screen.dart';

void main() {
  runApp(const EcoPointApp());
}

class EcoPointApp extends StatelessWidget {
  const EcoPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoPoint',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F8F5),
      ),
      home: const EcoPointScreen(),
    );
  }
}
