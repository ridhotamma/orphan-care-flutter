import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/services/connectivity_service.dart';
import 'package:frontend_flutter/services/analytics_service.dart';
import 'package:frontend_flutter/services/user_service.dart';
import 'package:frontend_flutter/services/document_service.dart';
import 'package:frontend_flutter/models/analytic_model.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:provider/provider.dart';
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
  bool _isDisconnected = false;

  final ConnectivityService _connectivityService = ConnectivityService();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late StreamSubscription _eventBusSubscription;
  late Future<AnalyticData> _analyticsData;
  late Future<UserResponse> _currentUser;
  late Future<List<Document>> _documentsFuture;

  @override
  void initState() {
    super.initState();

    _fetchData();

    _connectivitySubscription = _connectivityService.connectivityStream
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showSnackBar('No internet connection', 'disconnect');

        setState(() {
          _isDisconnected = true;
        });
      } else if (_isDisconnected &&
          (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile)) {
        setState(() {
          _isDisconnected = false;
        });
        _refreshData();
        _showSnackBar('Connected to the internet', 'connect');
      }
    });

    _eventBusSubscription = eventBus.on<DocumentChangedEvent>().listen((event) {
      _refreshData();
    });
  }

  Future<void> _fetchData() async {
    final analyticDataFuture =
        AnalyticsService(context: context).fetchHomePageAnalytics();
    final currentUserFuture = UserService(context: context).fetchCurrentUser();
    final documentsFuture =
        DocumentService(context: context).fetchCurrentUserDocuments();

    setState(() {
      _analyticsData = analyticDataFuture;
      _currentUser = currentUserFuture;
      _documentsFuture = documentsFuture;
    });

    currentUserFuture.then((data) {
      Provider.of<AuthProvider>(context, listen: false).setUserId(data.id);
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
      'disconnect': AppStyleConfig.errorColor,
      'connect': AppStyleConfig.successColor
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
          textColor: Colors.white,
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
    _eventBusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        analyticsDataFuture: _analyticsData,
        currentUserFuture: _currentUser,
      ),
      DocumentScreen(documentsFuture: _documentsFuture),
      SettingsScreen(
        currentUserFuture: _currentUser,
      ),
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
