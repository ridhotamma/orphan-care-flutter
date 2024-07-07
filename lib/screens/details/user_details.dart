import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/routes/routes.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class UserDetails extends StatelessWidget {
  final String id;

  const UserDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: "User Details",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileCard(context),
            _buildDetailList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: AppStyleConfig.accentColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const Positioned(
                  bottom: -70.0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(
                          'https://image.cnbcfm.com/api/v1/image/107203114-1677872178166-GettyImages-1382525205.jpg?v=1677940236'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90.0),
            const Center(
              child: Text(
                'Jane Smith',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            const Center(
              child: Text(
                'Lorem ipsum doler sit amet doler header',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 10.0),
            _buildChips(),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildChips() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          const Chip(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Female',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Icon(
                  Icons.female_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.symmetric(horizontal: 1.0),
          ),
          Chip(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: const Text(
                    'Ummu Kultsum',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 5.0),
                const Icon(
                  Icons.bed,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            backgroundColor: Colors.black54,
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildListTile(
          leadingIcon: Icons.info,
          title: 'Basic Information',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.userBasicInformation,
              arguments: id,
            );
          },
        ),
        _buildListTile(
          leadingIcon: Icons.person,
          title: 'Profile',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.userProfileDetails,
              arguments: id,
            );
          },
        ),
        _buildListTile(
          leadingIcon: Icons.location_on,
          title: 'Address',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.userAddressDetails,
              arguments: id,
            );
          },
        ),
        _buildListTile(
          leadingIcon: Icons.file_copy,
          title: 'Documents',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.userUploadDocuments,
              arguments: id,
            );
          },
        ),
        _buildListTile(
          leadingIcon: Icons.settings,
          title: 'Personal Settings',
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.userPersonalSettings,
              arguments: id,
            );
          },
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData leadingIcon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor = Colors.grey,
    Color? textColor,
    Widget trailingWidget = const Icon(Icons.arrow_forward_ios),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
}
