import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class ResponseHandlerUtils {
  static void onSubmitFailed(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.errorColor,
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          },
        ),
      ),
    );
  }

  static void onSubmitSuccess(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.successColor,
        content: Text(
          successMessage,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          },
        ),
      ),
    );
  }
}
