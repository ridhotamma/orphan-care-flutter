import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/services/upload_service.dart';

class UploadBottomSheet extends StatelessWidget {
  const UploadBottomSheet({super.key});

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final fileBytes = result.files.single.bytes;
      final fileName = result.files.single.name;

      if (fileBytes != null) {
        if (context.mounted) {
          final uploadService = UploadService(context: context);
          await uploadService.uploadFileBytes(fileBytes, fileName).then((data) {
            Navigator.of(context).pop();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select a file to upload',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _pickFile(context),
            style: AppStyleConfig.primaryButtonStyle,
            child: const Text("Pick File"),
          ),
        ],
      ),
    );
  }
}
