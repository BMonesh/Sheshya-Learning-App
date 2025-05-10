import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A5AE0),
          primary: const Color(0xFF6A5AE0),
          secondary: const Color(0xFFFF8FA2),
          tertiary: const Color(0xFFFFD66B),
          background: const Color(0xFFF5F5F5),
        ),
        fontFamily: 'Nunito',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFF555555),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF555555),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
