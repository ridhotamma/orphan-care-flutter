import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter/providers/localization_provider.dart';
import 'package:frontend_flutter/screens/details/bedroom_details.dart';
import 'package:frontend_flutter/screens/details/caretaker_details.dart';
import 'package:frontend_flutter/screens/details/inventory_details.dart';
import 'package:frontend_flutter/screens/details/orphan_details.dart';
import 'package:frontend_flutter/screens/login_screen.dart';
import 'package:frontend_flutter/screens/main_screen.dart';
import 'package:frontend_flutter/screens/home_screen.dart';
import 'package:frontend_flutter/screens/document_screen.dart';
import 'package:frontend_flutter/screens/settings_screen.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  final authProvider = AuthProvider();
  await authProvider.initFuture;

  final localizationProvider = LocalizationProvider();
  await localizationProvider.initFuture;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<LocalizationProvider>(
          create: (_) => LocalizationProvider(),
        ),
      ],
      child: const OrphanCareApp(),
    ),
  );
}

class OrphanCareApp extends StatelessWidget {
  const OrphanCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return MaterialApp(
      title: "Orphan Care",
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: localizationProvider.locale,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomeScreen(),
        '/home/orphan_details': (context) => const OrphanDetails(),
        '/home/caretaker_details': (context) => const CareTakerDetails(),
        '/home/bedroom_details': (context) => const BedroomDetails(),
        '/home/inventory_details': (context) => const InventoryDetails(),
        '/documents': (context) => const DocumentScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
