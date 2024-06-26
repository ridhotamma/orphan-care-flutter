import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_flutter/screens/details/bedroom_details.dart';
import 'package:frontend_flutter/screens/details/guardian_details.dart';
import 'package:frontend_flutter/screens/details/inventory_details.dart';
import 'package:frontend_flutter/screens/details/orphan_details.dart';
import 'package:frontend_flutter/screens/login_screen.dart';
import 'package:frontend_flutter/screens/main_screen.dart';
import 'package:frontend_flutter/screens/home_screen.dart';
import 'package:frontend_flutter/screens/document_screen.dart';
import 'package:frontend_flutter/screens/settings_screen.dart';
import 'package:frontend_flutter/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(const OrphanCareApp());
}

class OrphanCareApp extends StatelessWidget {
  const OrphanCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService(context);

    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: "Orphan Care",
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(apiService: apiService),
          '/main': (context) => MainScreen(apiService: apiService),
          '/home': (context) => const HomeScreen(),
          '/home/orphan_details': (context) => const OrphanDetails(),
          '/home/guardian_details': (context) => const GuardianDetails(),
          '/home/bedroom_details': (context) => const BedroomDetails(),
          '/home/inventory_details': (context) => const InventoryDetails(),
          '/documents': (context) => const DocumentScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
