import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class OrphanCreateForm extends StatefulWidget {
  const OrphanCreateForm({super.key});

  @override
  State<OrphanCreateForm> createState() => _OrphanCreateForm();
}

class _OrphanCreateForm extends State<OrphanCreateForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create User Form',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          tabs: const [
            Tab(text: 'Account'),
            Tab(text: 'Profile'),
            Tab(text: 'Document'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAccount(),
          _buildProfile(),
          _buildDocument(),
        ],
      ),
    );
  }

  Widget _buildAccount() {
    return const Center(
      child: Text('Account Form Placeholder'),
    );
  }

  Widget _buildProfile() {
    return const Center(
      child: Text('Profile Form Placeholder'),
    );
  }

  Widget _buildDocument() {
    return const Center(
      child: Text('Document Form Placeholder'),
    );
  }
}
