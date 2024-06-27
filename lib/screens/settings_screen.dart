import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLanguageListItem(),
          _buildAboutAppListItem(context),
          _buildLogoutListItem(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Settings',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: AppStyleConfig.secondaryColor,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildLanguageListItem() {
    return _buildListItem(
      leadingIcon: Icons.language,
      title: 'Language',
      trailingWidget: DropdownButton<String>(
        value: 'English',
        onChanged: (value) {},
        items: ['English', 'Spanish']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutAppListItem(BuildContext context) {
    return _buildListItem(
      leadingIcon: Icons.info_outline,
      title: 'About App',
      onTap: () {},
    );
  }

  Widget _buildLogoutListItem(BuildContext context) {
    return _buildListItem(
      leadingIcon: Icons.logout,
      title: 'Logout',
      textColor: AppStyleConfig.errorColor,
      iconColor: AppStyleConfig.errorColor,
      onTap: () => _showLogoutBottomSheet(context),
    );
  }

  Widget _buildListItem({
    required IconData leadingIcon,
    required String title,
    Widget? trailingWidget,
    Function()? onTap,
    Color? textColor,
    Color? iconColor = Colors.black,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(leadingIcon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailingWidget,
        onTap: onTap,
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          _buildLogoutBottomSheetContent(context),
    );
  }

  Widget _buildLogoutBottomSheetContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text(
              'Confirm Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Are you sure you want to logout?'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .clearToken();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: AppStyleConfig.errorColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
