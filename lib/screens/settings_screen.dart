import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

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
    );
  }

  Widget _buildLanguageListItem() {
    return _buildListItem(
      leadingIcon: Icons.language,
      title: 'Language',
      trailingWidget: DropdownButton<String>(
        value: 'English', // Replace with actual logic
        onChanged: (value) {
          // Implement logic to change language
        },
        items: ['English', 'Spanish'] // Replace with your languages
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
      onTap: () {
        // Implement logic to navigate to about screen or show dialog
      },
    );
  }

  Widget _buildLogoutListItem(BuildContext context) {
    return _buildListItem(
      leadingIcon: Icons.logout,
      title: 'Logout',
      textColor: AppStyleConfig.errorColor,
      iconColor: AppStyleConfig.errorColor,
      onTap: () {
        _showLogoutBottomSheet(context);
      },
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
        color: Colors.grey[200], // Background color
        border: Border.all(color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(leadingIcon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.black, // Default text color
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
      builder: (BuildContext context) {
        return _buildLogoutBottomSheetContent(context);
      },
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
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Implement logout action, e.g., clear user session
                  Navigator.of(context).pop(); // Close the bottom sheet
                  // Navigate to login screen or initial screen
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
