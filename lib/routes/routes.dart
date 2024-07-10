import 'package:flutter/material.dart';
import 'package:frontend_flutter/main.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/screens/details/bedroom_details.dart';
import 'package:frontend_flutter/screens/details/inventory_details.dart';
import 'package:frontend_flutter/screens/details/user_details.dart';
import 'package:frontend_flutter/screens/form/bedroom_create_form.dart';
import 'package:frontend_flutter/screens/form/caretaker_create_form.dart';
import 'package:frontend_flutter/screens/form/inventory_create_form.dart';
import 'package:frontend_flutter/screens/form/orphan_create_form.dart';
import 'package:frontend_flutter/screens/list/bedroom_list.dart';
import 'package:frontend_flutter/screens/list/caretaker_list.dart';
import 'package:frontend_flutter/screens/list/inventory_list.dart';
import 'package:frontend_flutter/screens/list/orphan_list.dart';
import 'package:frontend_flutter/screens/login_screen.dart';
import 'package:frontend_flutter/screens/main_screen.dart';
import 'package:frontend_flutter/screens/shared/user_address_details.dart';
import 'package:frontend_flutter/screens/shared/user_basic_information.dart';
import 'package:frontend_flutter/screens/shared/user_personal_settings.dart';
import 'package:frontend_flutter/screens/shared/user_profile_details.dart';
import 'package:frontend_flutter/screens/shared/user_upload_documents.dart';
import 'package:provider/provider.dart';

class RoutePaths {
  static const String login = '/';
  static const String main = '/main';
  static const String orphanList = '/main/orphan_list';
  static const String orphanDetails = '/main/orphan_details';
  static const String orphanCreateForm = '/main/orphan_create';

  static const String caretakerList = '/main/caretaker_list';
  static const String caretakerDetails = '/main/caretaker_details';
  static const String caretakerCreateForm = '/main/caretaker_create';

  static const String bedroomList = '/main/bedroom_list';
  static const String bedroomDetails = '/main/bedroom_details';
  static const String bedroomCreateForm = '/main/bedroom_create';

  static const String inventoryList = '/main/inventory_list';
  static const String inventoryDetails = '/main/inventory_details';
  static const String inventoryCreateForm = '/main/inventory_create';

  static const String currentUserDetails = '/main/settings/profile';
  static const String userBasicInformation = '/main/users/basic_information';
  static const String userPersonalSettings = '/main/users/personal_settings';
  static const String userProfileDetails = '/main/users/profile_details';
  static const String userUploadDocuments = '/main/users/documents';
  static const String userAddressDetails = '/main/users/address';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final authProvider =
        Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false);

    switch (settings.name) {
      case RoutePaths.login:
        if (authProvider.hasToken) {
          return MaterialPageRoute(builder: (_) => const MainScreen());
        }
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RoutePaths.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case RoutePaths.orphanList:
        return MaterialPageRoute(builder: (_) => const OrphanList());

      case RoutePaths.orphanDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserDetails(id: id));

      case RoutePaths.orphanCreateForm:
        return MaterialPageRoute(builder: (_) => const OrphanCreateForm());

      case RoutePaths.caretakerList:
        return MaterialPageRoute(builder: (_) => const CaretakerList());

      case RoutePaths.caretakerDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserDetails(id: id));

      case RoutePaths.caretakerCreateForm:
        return MaterialPageRoute(builder: (_) => const CaretakerCreateForm());

      case RoutePaths.bedroomList:
        return MaterialPageRoute(builder: (_) => const BedroomList());

      case RoutePaths.bedroomDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => BedroomDetails(id: id));

      case RoutePaths.bedroomCreateForm:
        return MaterialPageRoute(builder: (_) => const BedroomCreateForm());

      case RoutePaths.inventoryList:
        return MaterialPageRoute(builder: (_) => const InventoryList());

      case RoutePaths.inventoryDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => InventoryDetails(id: id));

      case RoutePaths.inventoryCreateForm:
        return MaterialPageRoute(builder: (_) => const InventoryCreateForm());

      case RoutePaths.currentUserDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserDetails(id: id));

      case RoutePaths.userBasicInformation:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserBasicInformation(id: id));

      case RoutePaths.userPersonalSettings:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserPersonalSettings(id: id));

      case RoutePaths.userProfileDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserProfileDetails(id: id));

      case RoutePaths.userUploadDocuments:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserUploadDocuments(id: id));

      case RoutePaths.userAddressDetails:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => UserAddressDetails(id: id));

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
