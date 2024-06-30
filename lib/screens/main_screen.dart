import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/services/connectivity_service.dart';
import 'package:frontend_flutter/services/analytics_service.dart';
import 'package:frontend_flutter/services/user_service.dart';
import 'package:frontend_flutter/models/analytic_model.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'home_screen.dart';
import 'document_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final ConnectivityService _connectivityService = ConnectivityService();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late Future<AnalyticData> _analyticsData;
  late Future<CurrentUser> _currentUser;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _connectivitySubscription = _connectivityService.connectivityStream
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showSnackBar('No internet connection', 'error');
      } else {
        _showSnackBar('Connected to the internet', 'connect');
      }
    });
  }

  Future<void> _fetchData() async {
    setState(() {
      _analyticsData = AnalyticsService(context).fetchHomePageAnalytics();
      _currentUser = UserService(context).fetchCurrentUser();
    });
  }

  Future<void> _refreshData() async {
    await _fetchData();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showSnackBar(String message, String type) {
    Map<String, dynamic> backgroundStylesMap = {
      'error': AppStyleConfig.errorColor,
      'connect': Colors.blue
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundStylesMap[type],
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        analyticsDataFuture: _analyticsData,
        currentUserFuture: _currentUser,
      ),
      const DocumentScreen(),
      const SettingsScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyleConfig.primaryBackgroundColor,
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Builder(
            builder: (BuildContext context) {
              return screens[_currentIndex];
            },
          ),
        ),
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
