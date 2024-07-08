import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentPreview extends StatelessWidget {
  final String documentUrl;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  DocumentPreview({super.key, required this.documentUrl});

  Future<void> _downloadDocument(BuildContext context) async {
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
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String fileType = documentUrl.split('.').last;

        String savePath = '$tempPath/downloaded_file.$fileType';
        await Dio().download(documentUrl, savePath);

        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        String finalPath = '$appDocPath/downloaded_file.$fileType';

        File tempFile = File(savePath);
        await tempFile.copy(finalPath);

        if (context.mounted) {
          ResponseHandlerUtils.onSubmitSuccess(
              context, 'File downloaded to $savePath');
        }
      } else {
        if (context.mounted) {
          ResponseHandlerUtils.onSubmitFailed(
              context, 'Permission denied to save document');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ResponseHandlerUtils.onSubmitFailed(
            context, 'Failed to download document');
      }
    }
  }

  Widget _buildDownloadButton(BuildContext context) {
    if (kIsWeb) return const SizedBox.shrink();

    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              _downloadDocument(context);
            },
            style: AppStyleConfig.primaryButtonStyle,
            label: const Text('Download Document'),
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
        title: 'Document Preview',
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: SfPdfViewer.network(
                key: _pdfViewerKey,
                documentUrl,
              ),
            ),
            _buildDownloadButton(context),
          ],
        ),
      ),
    );
  }
}
