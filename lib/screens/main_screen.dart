import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/screens/form/orphan_create_form.dart';
import 'home_screen.dart';
import 'document_screen.dart';
import 'settings_screen.dart';
import 'package:frontend_flutter/screens/list/bedroom_list.dart';
import 'package:frontend_flutter/screens/list/caretaker_list.dart';
import 'package:frontend_flutter/screens/list/inventory_list.dart';
import 'package:frontend_flutter/screens/list/orphan_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreenNavigator(),
    const DocumentScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyleConfig.primaryBackgroundColor,
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppStyleConfig.primaryColor,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'Documents',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenNavigator extends StatelessWidget {
  const HomeScreenNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/main/home',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/main/home':
            builder = (BuildContext _) => const HomeScreen();
            break;
          case '/main/home/orphan_details':
            builder = (BuildContext _) => const OrphanList();
            break;
          case '/main/home/orphan_details/create':
            builder = (BuildContext _) => const OrphanCreateForm();
            break;
          case '/main/home/caretaker_details':
            builder = (BuildContext _) => const CaretakerList();
            break;
          case '/main/home/bedroom_details':
            builder = (BuildContext _) => const BedroomList();
            break;
          case '/main/home/inventory_details':
            builder = (BuildContext _) => const InventoryList();
            break;
          default:
            builder = (BuildContext _) => const HomeScreen();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
