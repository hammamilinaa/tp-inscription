import 'package:flutter/material.dart';
import 'screens/step_one_screen.dart';
import 'theme/app_theme.dart';
 import 'tp_inscription/utils/validators.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inscription',
      theme: AppTheme.light,
      home: const StepOneScreen(),
    );
  }
}