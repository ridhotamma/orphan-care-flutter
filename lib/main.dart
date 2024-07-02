import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter/providers/localization_provider.dart';
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
        ChangeNotifierProvider<LocalizationProvider>.value(
            value: localizationProvider),
      ],
      child: const OrphanCareApp(),
    ),
  );
}

class OrphanCareApp extends StatelessWidget {
  const OrphanCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return MaterialApp(
      title: "Orphan Care",
      locale: localizationProvider.locale,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: authProvider.hasToken ? RoutePaths.main : RoutePaths.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
