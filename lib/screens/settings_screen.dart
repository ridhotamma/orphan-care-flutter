import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/providers/localization_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: localization.translate('settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLanguageListItem(context, localization),
          _buildAboutAppListItem(context, localization),
          _buildLogoutListItem(context, localization),
        ],
      ),
    );
  }

  Widget _buildLanguageListItem(
      BuildContext context, AppLocalizations localization) {
    final languages = {
      'id': 'Indonesian',
      'en': 'English',
    };

    return _buildListItem(
      leadingIcon: Icons.language,
      title: localization.translate('language'),
      trailingWidget: DropdownButton<String>(
        value: Provider.of<LocalizationProvider>(context).locale.languageCode,
        onChanged: (value) {
          if (value != null) {
            Provider.of<LocalizationProvider>(context, listen: false)
                .setLocale(Locale(value));
          }
        },
        items: languages.entries.map<DropdownMenuItem<String>>((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutAppListItem(
      BuildContext context, AppLocalizations localization) {
    return _buildListItem(
      leadingIcon: Icons.info_outline,
      title: localization.translate('about_app'),
      onTap: () {},
    );
  }

  Widget _buildLogoutListItem(
      BuildContext context, AppLocalizations localization) {
    return _buildListItem(
      leadingIcon: Icons.logout,
      title: localization.translate('logout'),
      textColor: AppStyleConfig.errorColor,
      iconColor: AppStyleConfig.errorColor,
      onTap: () => _showLogoutBottomSheet(context, localization),
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

  void _showLogoutBottomSheet(
      BuildContext context, AppLocalizations localization) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          _buildLogoutBottomSheetContent(context, localization),
    );
  }

  Widget _buildLogoutBottomSheetContent(
      BuildContext context, AppLocalizations localization) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              localization.translate('confirm_logout'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(localization.translate('confirm_logout_message')),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(localization.translate('cancel')),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .clearToken();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: Text(
                  localization.translate('logout'),
                  style: const TextStyle(color: AppStyleConfig.errorColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
