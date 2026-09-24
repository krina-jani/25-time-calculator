import 'package:flutter/material.dart';
import 'pages/calculator_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TimeCalculatorApp());
}

class TimeCalculatorApp extends StatelessWidget {
  const TimeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          primary: const Color(0xFF1E3A8A),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A),
          elevation: 1,
          centerTitle: false,
        ),
      ),
      home: const CalculatorPage(),
    );
  }
}
