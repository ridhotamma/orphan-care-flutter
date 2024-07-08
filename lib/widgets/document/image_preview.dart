import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/utils/response_handler_util.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;

  const ImagePreview({super.key, required this.imageUrl});

  Future<void> _downloadImage(BuildContext context) async {
    try {
      bool isGranted = true;

      if (Platform.isAndroid) {
        final deviceInfoPlugin = DeviceInfoPlugin();
        final deviceInfo = await deviceInfoPlugin.androidInfo;
        final sdkInt = deviceInfo.version.sdkInt;

        if (sdkInt > 33) {
          isGranted = await Permission.photos.request().isGranted;
        } else {
          isGranted = await Permission.storage.request().isGranted;
        }
      }

      if (isGranted) {
        var response = await Dio().get(
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        String fileName = imageUrl.split('/').last.split('.').first;
        final result = await SaverGallery.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: fileName,
          androidRelativePath: "Pictures/orphancare",
          androidExistNotSave: false,
        );

        if (result.isSuccess) {
          if (context.mounted) {
            ResponseHandlerUtils.onSubmitSuccess(
                context, 'Image saved to gallery');
          }
        } else {
          if (context.mounted) {
            ResponseHandlerUtils.onSubmitFailed(
                context, 'Failed to save image to gallery');
          }
        }
      } else {
        if (context.mounted) {
          ResponseHandlerUtils.onSubmitFailed(
              context, 'Permission denied to save image');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(
            context, 'Failed to download image');
      }
    }
  }

  Widget _buildDownloadButton(BuildContext context) {
    if (kIsWeb) return const SizedBox.shrink();

    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              _downloadImage(context);
            },
            style: AppStyleConfig.primaryButtonStyle,
            label: const Text('Download Image'),
            icon: const Icon(Icons.download),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Image Preview',
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
              ),
            ),
            _buildDownloadButton(context),
          ],
        ),
      ),
    );
  }
}
