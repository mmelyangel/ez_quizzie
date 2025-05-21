import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(EZQuizzie());
}

class EZQuizzie extends StatelessWidget {
  const EZQuizzie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Quizzie',
      theme: ThemeData(
        primaryColor: const Color(0xFF6A5ACD),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6A5ACD),
          secondary: const Color(0xFFFF8C00),
          surface: const Color.fromARGB(255, 74, 163, 240),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8C00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A5ACD),
          ),
          displayMedium: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A5ACD),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontSize: 16,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Comic Sans MS',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF6A5ACD), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF6A5ACD), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFFF8C00), width: 3),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
