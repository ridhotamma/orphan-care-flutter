import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.centerTitle = true,
      this.backgroundColor = AppStyleConfig.secondaryColor,
      this.automaticallyImplyLeading = false,
      this.actions,
      this.foregroundColor,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      foregroundColor: foregroundColor,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
