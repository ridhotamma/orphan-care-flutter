import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/providers/localization_provider.dart';
import 'package:shimmer/shimmer.dart';

class SettingsScreen extends StatelessWidget {
  final Future<CurrentUser> currentUserFuture;

  const SettingsScreen({
    super.key,
    required this.currentUserFuture,
  });

  String getRoleText(List<String> roles) {
    if (roles.contains('ROLE_USER') && roles.contains('ROLE_ADMIN')) {
      return 'Administrator';
    } else if (roles.contains('ROLE_ADMIN')) {
      return 'Pengasuh';
    } else if (roles.contains('ROLE_USER')) {
      return 'Anak Asuh';
    } else {
      return 'Unknown Role';
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: CustomAppBar(title: localization.translate('settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileListItem(context, localization),
          _buildLanguageListItem(context, localization),
          _buildAboutAppListItem(context, localization),
          _buildLogoutListItem(context, localization),
        ],
      ),
    );
  }

  Widget _buildProfileListItem(
      BuildContext context, AppLocalizations localization) {
    return FutureBuilder<CurrentUser>(
      future: currentUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                snapshot.data!.username,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(getRoleText(snapshot.data!.roles.toList())),
              leading: const CircleAvatar(
                radius: 20.0,
                backgroundColor: AppStyleConfig.accentColor,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjPtBPtOIj16drcpc4Ht93MyJgtRH89ikp_Q&s'),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        } else {
          return const Center(
            child: Text('No Data Available'),
          );
        }
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          tileColor: Colors.white,
          title: Container(
            height: 16,
            color: Colors.grey,
          ),
          subtitle: Container(
            height: 14,
            color: Colors.grey,
            margin: const EdgeInsets.only(top: 4),
          ),
          leading: const CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.grey,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ),
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
        color: Colors.white,
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
