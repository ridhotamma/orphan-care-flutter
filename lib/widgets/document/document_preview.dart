import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class DocumentPreview extends StatelessWidget {
  final String documentUrl;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  DocumentPreview({super.key, required this.documentUrl});

  Future<void> _downloadDocument(BuildContext context) async {
    try {
      bool isGranted = false;

      if (Platform.isAndroid) {
        final deviceInfoPlugin = DeviceInfoPlugin();
        final deviceInfo = await deviceInfoPlugin.androidInfo;
        final sdkInt = deviceInfo.version.sdkInt;

        if (sdkInt > 33) {
          isGranted = await Permission.photos.request().isGranted;
        } else {
          isGranted = await Permission.storage.request().isGranted;
        }
      } else if (Platform.isIOS) {
        isGranted = await Permission.photos.request().isGranted;
      }

      if (isGranted) {
        final response = await http.get(Uri.parse(documentUrl));
        final bytes = response.bodyBytes;

        Directory directory;
        if (Platform.isAndroid) {
          directory = (await getExternalStorageDirectory())!;
        } else if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        } else {
          directory = await getApplicationDocumentsDirectory();
        }

        final path = '${directory.path}/${documentUrl.split('/').last}';
        final file = File(path);
        await file.writeAsBytes(bytes);

        if (context.mounted) {
          ResponseHandlerUtils.onSubmitSuccess(
              context, 'File downloaded to $path');
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
