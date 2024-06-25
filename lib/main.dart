import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/login_screen.dart';
import 'package:frontend_flutter/screens/main_screen.dart';
import 'package:frontend_flutter/screens/home_screen.dart';
import 'package:frontend_flutter/screens/document_screen.dart';
import 'package:frontend_flutter/screens/settings_screen.dart';

void main() {
  runApp(const OrphanCareApp());
}

class OrphanCareApp extends StatelessWidget {
  const OrphanCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Orphan Care",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomeScreen(),
        '/documents': (context) => const DocumentScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
