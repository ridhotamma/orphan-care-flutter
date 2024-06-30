import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/details/orphan_details.dart';
import 'package:frontend_flutter/screens/document_screen.dart';
import 'package:frontend_flutter/screens/form/orphan_create_form.dart';
import 'package:frontend_flutter/screens/home_screen.dart';
import 'package:frontend_flutter/screens/list/bedroom_list.dart';
import 'package:frontend_flutter/screens/list/caretaker_list.dart';
import 'package:frontend_flutter/screens/list/inventory_list.dart';
import 'package:frontend_flutter/screens/list/orphan_list.dart';
import 'package:frontend_flutter/screens/login_screen.dart';
import 'package:frontend_flutter/screens/main_screen.dart';
import 'package:frontend_flutter/screens/settings_screen.dart';

class RoutePaths {
  static const String login = '/';
  static const String main = '/main';
  static const String home = '/main/home';
  static const String documents = '/main/documents';
  static const String settings = '/main/settings';
  static const String orphanList = '/main/home/orphan_list';
  static const String orphanDetails = '/main/home/orphan_details';
  static const String orphanCreateForm = '/main/home/orphan_details/create';
  static const String caretakerList = '/main/home/caretaker_list';
  static const String bedroomList = '/main/home/bedroom_list';
  static const String inventoryList = '/main/home/inventory_list';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePaths.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutePaths.orphanList:
        return MaterialPageRoute(builder: (_) => const OrphanList());
      case RoutePaths.orphanDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OrphanDetails(id: id));
      case RoutePaths.orphanCreateForm:
        return MaterialPageRoute(builder: (_) => const OrphanCreateForm());
      case RoutePaths.caretakerList:
        return MaterialPageRoute(builder: (_) => const CaretakerList());
      case RoutePaths.bedroomList:
        return MaterialPageRoute(builder: (_) => const BedroomList());
      case RoutePaths.inventoryList:
        return MaterialPageRoute(builder: (_) => const InventoryList());
      case RoutePaths.documents:
        return MaterialPageRoute(builder: (_) => const DocumentScreen());
      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
