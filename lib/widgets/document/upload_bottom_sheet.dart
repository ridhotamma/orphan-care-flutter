import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/services/upload_service.dart';

class UploadBottomSheet extends StatefulWidget {
  const UploadBottomSheet({super.key});

  @override
  State<UploadBottomSheet> createState() => _UploadBottomSheetState();
}

class _UploadBottomSheetState extends State<UploadBottomSheet> {
  Uint8List? _fileBytes;
  String? _fileName;
  String? _fileType;
  final TextEditingController _fileNameController = TextEditingController();
  final List<String> _fileTypes = ['pdf', 'image'];

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileBytes = result.files.single.bytes;
        _fileName = result.files.single.name;
        _fileNameController.text = _fileName ?? '';
      });
    }
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (_fileBytes != null && _fileName != null && _fileType != null) {
      if (context.mounted) {
        final uploadService = UploadService(context: context);
        await uploadService
            .uploadFileBytes(_fileBytes!, _fileName!)
            .then((data) {
          if (kDebugMode) {
            print(data);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Upload Document',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: _fileBytes != null
                ? Image.memory(
                    _fileBytes!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.cloud_upload,
                    size: 100,
                    color: Colors.grey[400],
                  ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _pickFile(context),
            style: AppStyleConfig.primaryButtonStyle,
            child: const Text("Upload Image"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _fileNameController,
            decoration: AppStyleConfig.inputDecoration.copyWith(
              hintText: 'File Name',
              labelText: 'File Name',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _fileType,
            onChanged: (String? newValue) {
              setState(() {
                _fileType = newValue;
              });
            },
            items: _fileTypes.map<DropdownMenuItem<String>>((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type.toUpperCase()),
              );
            }).toList(),
            decoration: AppStyleConfig.inputDecoration.copyWith(
                hintText: 'File Type',
                labelText: 'File Type',
                border: const OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: AppStyleConfig.secondaryButtonStyle,
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => _uploadFile(context),
                style: AppStyleConfig.primaryButtonStyle,
                child: const Text("Create Document"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
